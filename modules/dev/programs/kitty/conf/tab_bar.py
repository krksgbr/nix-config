import math
import socket
import subprocess
from pathlib import Path
from typing import Any, Callable, Dict, List, Optional
from dataclasses import dataclass
from kittens.ssh.utils import get_connection_data
from kitty.boss import Boss
from kitty.fast_data_types import Color, Screen, get_boss, get_options
from kitty.tab_bar import Dict, DrawData, ExtraData, TabBarData, as_rgb, draw_title
from kitty.utils import color_as_int
from kitty.window import Window

# Whether to add padding to title of tabs
PADDED_TABS = True

# Whether to draw a separator between tabs
DRAW_SOFT_SEP = True

# Whether to draw right-hand side status information inside of filled shapes
RHS_STATUS_FILLED = True

# Separators and status icons
LEFT_SEP = ""
RIGHT_SEP = ""
SOFT_SEP = "│"
PADDING = " "
BRANCH_ICON = "󰘬"
ELLIPSIS = "…"
PAGER_ICON = "󰦪"

# Colors
SOFT_SEP_COLOR = Color(89, 89, 89)
FILLED_ICON_BG_COLOR = Color(89, 89, 89)
ACCENTED_BG_COLOR = Color(30, 104, 199)
ACCENTED_ICON_BG_COLOR = Color(53, 132, 228)

MAX_BRANCH_LEN = 21

MIN_TAB_LEN = (
        0
)

@dataclass
class Theme:
    foreground: Color
    background: Color

@dataclass
class Config:
    active_tab: Theme
    inactive_tab: Theme
    hostname: Theme
    ssh_hostname: Theme
    info: Theme
    stacked: Theme


def parse_color(c):
    return as_rgb(color_as_int(c))

def get_config(opts):
    return Config (
            active_tab = Theme(
                foreground = parse_color(opts.active_tab_foreground),
                background = parse_color(opts.active_tab_background)
                ),
            inactive_tab = Theme (
                foreground = parse_color(opts.inactive_tab_foreground),
                background = parse_color(opts.inactive_tab_background),
                ),
            hostname = Theme (
                foreground  = parse_color(opts.inactive_tab_background),
                background = parse_color(opts.color13)
                ),
            ssh_hostname = Theme (
                background = parse_color(opts.color5),
                foreground = parse_color(opts.inactive_tab_background)
                ),
            stacked = Theme (
                background = parse_color(opts.color6),
                foreground = parse_color(opts.inactive_tab_background)
                ),
            info = Theme (
                background = parse_color(opts.color4),
                foreground = parse_color(opts.inactive_tab_background)
                )
            )

@dataclass
class Element:
    theme: Theme
    title: DrawData | str = ""
    prefix: str = ""
 
@dataclass
class SysInfo:
    host: str
    is_ssh: bool


def _draw_element(
    element: Element,
    background: Color,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    padded: bool = False,
    soft_sep: Optional[str] = None,
) -> int:
    # When max_tab_length < MIN_TAB_LEN, we just draw an ellipsis, without separators or
    # anything else, so that it's clear that one either needs a larger max_tab_length,
    # or another tab bar design
    if max_tab_length < MIN_TAB_LEN:
        screen.draw("…".center(max_tab_length))
        return screen.cursor.x

    components = list()
    theme = element.theme
    icon = element.prefix
    title = element.title
    
    # # Left separator
    components.append((LEFT_SEP, theme.background, background))
    # Padding between left separator and rest of tab
    if padded:
        components.append((PADDING, theme.foreground, theme.background))
    # Icon, with padding on the right if there's a tab title, and more padding before
    # title if the tab is filled and there's a tab title
    if icon:
        components.append((f"{icon}{PADDING}", theme.foreground, theme.background))
        if title != "":
            components.append((PADDING, theme.foreground, theme.background))
    # Title
    components.append((title, theme.foreground, theme.background))
    # Padding between tab content and right separator
    if padded:
        components.append((PADDING, theme.foreground, theme.background))
    components.append((RIGHT_SEP, theme.background, background))
    # Inter-tab soft separator
    if soft_sep:
        components.append((soft_sep, background, background))

    for c in components:
        screen.cursor.fg = c[1]
        screen.cursor.bg = c[2]
        print(c[0])
        if isinstance(c[0], str):
            screen.draw(c[0])
        else:
            draw_title(c[0], screen, tab, index)
            max_cursor_x = before + max_tab_length - len(LEFT_SEP) - len(PADDING)
            if screen.cursor.x > max_cursor_x:
                screen.cursor.x = max_cursor_x - 1
                screen.draw("…")
    
    # # Element ends before soft separator
    end = screen.cursor.x - (len(soft_sep) if soft_sep else 0)
    return end


def _calc_elements_len(elements: List[Element]) -> int:
    elements_len = 0
    for element in elements:
        title, icon = element.title, element.prefix
        # Icon
        elements_len += len(icon)
        # Icon padding, if element has a title
        elements_len += len(PADDING) if title != "" else 0
        # Title
        elements_len += len(title)
        # Separators
        elements_len += 2
        if RHS_STATUS_FILLED:
            # Title padding, if element has a title
            elements_len += len(PADDING) if title != "" else 0
    # Inter-tab soft separators
    elements_len += len(elements) - 1
    return elements_len


def _is_running_pager(active_window: Window) -> bool:
    try:
        return Path(active_window.child.argv[0]).name == "nvim-pager.py"
    except:
        return False


def _get_system_info(active_window: Window) -> SysInfo:
    host = socket.gethostname()
    is_ssh = False

    ssh_cmdline = []
    # The propery "child_is_remote" is True when the command being executed is a
    # standard "ssh" command, without using the SSH kitten
    if active_window.child_is_remote:
        procs = sorted(active_window.child.foreground_processes, key=lambda p: p["pid"])
        for p in procs:
            if p["cmdline"][0] == "ssh":
                ssh_cmdline = p["cmdline"]
    # The command line is not an empty list in case we're running the ssh kitten
    else:
        ssh_cmdline = active_window.ssh_kitten_cmdline()

    if ssh_cmdline != []:
        is_ssh = True
        # Remove "-tt" argument from SSH cmdline, if present, because the function
        # get_connection_data() doesn't handle that properly
        ssh_cmdline = filter(lambda item: item != "-tt", ssh_cmdline)
        conn_data = get_connection_data(ssh_cmdline)
        if conn_data:
            user_and_host = conn_data.hostname.split("@")
            if len(user_and_host) == 1:
                host = user_and_host[0]
            elif len(user_and_host) == 2:
                host = user_and_host[1]
            else:
                print("Could not parse user and host name")
        else:
            print("Could not retrieve SSH connection data")

    return SysInfo(host = host, is_ssh = is_ssh)


def _get_git_info(active_window: Window, is_ssh: bool) -> Dict[str, Any]:
    # Git info currently only works in non-remote windows
    if is_ssh:
        return {"is_git_repo": False, "branch": ""}

    cwd = active_window.cwd_of_child
    proc = subprocess.run(
        ["git", "branch", "--show-current"], capture_output=True, cwd=cwd
    )

    # If the command fails we're probably not in a Git repo (note that often the command
    # does not error out, so checking the stderr protects against false negatives)
    if proc.returncode != 0 or len(proc.stderr) > 0:
        return {"is_git_repo": False, "branch": ""}

    branch = str(proc.stdout, "utf-8").strip() or "DETACHED"
    if len(branch) > MAX_BRANCH_LEN:
        start_len = (MAX_BRANCH_LEN - 1) // 2
        end_len = MAX_BRANCH_LEN - start_len - 1
        branch = branch[:start_len] + ELLIPSIS + branch[-end_len:]
        print(start_len, end_len, len(branch))

    return {"is_git_repo": True, "branch": branch}


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    """Draw tab.

    Args:
        draw_data (DrawData): Tab context.
        screen (Screen): Screen objects.
        tab (TabBarData): Tab bar context.
        before (int): Current cursor position, before drawing tab.
        max_tab_length (int): User-specified maximum length of tab.
        index (int): Tab index.
        is_last (bool): Whether this is the last tab to draw.
        extra_data (ExtraData): Additional context.

    Returns:
        int: Cursor positions after drawing current tab.
    """

    opts = get_options()
    config = get_config(opts)

    tab_theme = config.inactive_tab
    tab_prefix = f"{index}:"
    if tab.is_active:
        if tab.layout_name == "stack":
            tab_theme = config.stacked
            tab_prefix = "⛶"
        else:
            tab_theme = config.active_tab

    # Draw main tabs
    end = _draw_element(
            Element(
                prefix = tab_prefix,
                title = draw_data,
                theme = tab_theme
                ),
            parse_color(draw_data.default_bg),
            screen,
            tab,
            before,
            max_tab_length,
            index,
            padded=PADDED_TABS,
            soft_sep=PADDING,
    )
    # Draw right-hand side status
    if is_last:
        boss: Boss = get_boss()
        active_window = boss.active_window
        assert isinstance(active_window, Window)

        is_running_pager = _is_running_pager(active_window)
        sys_info = _get_system_info(active_window)
        host, is_ssh = sys_info.host, sys_info.is_ssh
        git_info = _get_git_info(active_window, is_ssh)
        is_git_repo, branch = git_info["is_git_repo"], git_info["branch"]

        elements = list()
        if is_running_pager:
            elements.append(Element(prefix = PAGER_ICON, theme = config.info))
        if is_git_repo:
            elements.append(Element(title = branch, prefix = BRANCH_ICON, theme = config.info))
        elements.append(Element(title = f"{'SSH | ' if is_ssh else ''}{host}", prefix = "֎", theme = config.ssh_hostname if is_ssh else config.hostname))

        # Move cursor horizontally so that right-hand side status is right-aligned
        rhs_status_len = _calc_elements_len(elements)
        if opts.tab_bar_align == "center":
            screen.cursor.x = math.ceil(screen.columns / 2 + end / 2) - rhs_status_len
        else:  # opts.tab_bar_align == "left"
            screen.cursor.x = screen.columns - rhs_status_len

        for element in elements:
            _draw_element(
                element,
                parse_color(draw_data.default_bg),
                screen,
                tab,
                before,
                100,
                index,
                soft_sep=PADDING if element is not elements[-1] else None,
            )

    return end
