# vim:fileencoding=utf-8:ft=conf

# Font family. You can also specify different fonts for the
# bold/italic/bold-italic variants. By default they are derived automatically,
# by the OSes font system. Setting them manually is useful for font families
# that have many weight variants like Book, Medium, Thick, etc. For example:
# font_family Operator Mono Book
# bold_font Operator Mono Medium
# italic_font Operator Mono Book Italic
# bold_italic_font Operator Mono Medium Italic
#
# You can get a list of full family names available on your computer by running
# kitty list-fonts
font_family      Iosevka Nerd Font Complete
italic_font      Iosevka Italic Nerd Font Complete
bold_font        Iosevka Bold Nerd Font Complete
bold_italic_font Iosevka Bold Italic Nerd Font Complete 

# Font size (in pts)
font_size        12.0


# Adjust the cell dimensions.
# You can use either numbers, which are interpreted as pixels or percentages
# (number followed by %), which are interpreted as percentages of the
# unmodified values. You can use negative pixels or percentages less than
# 100% to reduce sizes (but this might cause rendering artifacts).
adjust_line_height 0
adjust_column_width 0

# Change the sizes of the lines used for the box drawing unicode characters
# These values are in pts. They will be scaled by the monitor DPI to arrive at
# a pixel value. There must be four values corresponding to thin, normal, thick,
# and very thick lines;
box_drawing_scale 0.001, 1, 1.5, 2


# The foreground color
foreground       #839496

# The background color
background       #002b36

# The opacity of the background. A number between 0 and 1, where 1 is opaque and 0 is fully transparent.
# This will only work if supported by the OS (for instance, when using a compositor under X11). Note
# that it only sets the default background color's opacity. This is so that
# things like the status bar in vim, powerline prompts, etc. still look good.
# But it means that if you use a color theme with a background color in your
# editor, it will not be rendered as transparent.  Instead you should change the
# default background color in your kitty config and not use a background color
# in the editor color scheme. Or use the escape codes to set the terminals
# default colors in a shell script to launch your editor.
# Be aware that using a value less than 1.0 is a (possibly significant) performance hit.
background_opacity 1.0

# The foreground for selections
selection_foreground #93a1a1

# The background for selections
selection_background #073642

# The cursor color
cursor          #00ff00
cursor_text_color #111111

# The cursor opacity
cursor_opacity   0.7

# The cursor shape can be one of (block, beam, underline)
cursor_shape     block

# The interval (in seconds) at which to blink the cursor. Set to zero to
# disable blinking.
cursor_blink_interval     0.5

# Stop blinking cursor after the specified number of seconds of keyboard inactivity. Set to
# zero to never stop blinking.
cursor_stop_blinking_after 15.0

# The color and style for highlighting URLs on mouse-over. url_style can be one of:
# none, single, double, curly
url_color #0087BD
url_style curly

# Number of lines of history to keep in memory for scrolling back
scrollback_lines 2000

# Program with which to view scrollback in a new window. The scrollback buffer is passed as
# STDIN to this program. If you change it, make sure the program you use can
# handle ANSI escape sequences for colors and text formatting.
scrollback_pager less +G -R

# Wheel scroll multiplier (modify the amount scrolled by the mouse wheel). Use negative
# numbers to change scroll direction.
wheel_scroll_multiplier 5.0

# The interval between successive clicks to detect double/triple clicks (in seconds)
click_interval 0.5

# Characters considered part of a word when double clicking. In addition to these characters
# any character that is marked as an alpha-numeric character in the unicode
# database will be matched.
select_by_word_characters :@-./_~?&=%+#

# The shell program to execute. The default value of . means
# to use whatever shell is set as the default shell for the current user.
shell .

# Hide mouse cursor after the specified number of seconds of the mouse not being used. Set to
# zero to disable mouse cursor hiding.
mouse_hide_wait 3.0

# Set the active window to the window under the mouse when moving the mouse around
focus_follows_mouse no

# The enabled window layouts. A comma separated list of layout names. The special value * means
# all layouts. The first listed layout will be used as the startup layout.
# For a list of available layouts, see the file layouts.py
enabled_layouts *

# If enabled, the window size will be remembered so that new instances of kitty will have the same
# size as the previous instance. If disabled, the window will initially have size configured
# by initial_window_width/height, in pixels.
remember_window_size   yes
initial_window_width   640
initial_window_height  400

# Delay (in milliseconds) between screen updates. Decreasing it, increases
# frames-per-second (FPS) at the cost of more CPU usage. The default value
# yields ~100 FPS which is more than sufficient for most uses.
repaint_delay    10

# Delay (in milliseconds) before input from the program running in the terminal
# is processed. Note that decreasing it will increase responsiveness, but also
# increase CPU usage and might cause flicker in full screen programs that
# redraw the entire screen on each loop, because kitty is so fast that partial
# screen updates will be drawn.
input_delay 3

# Visual bell duration. Flash the screen when a bell occurs for the specified number of
# seconds. Set to zero to disable.
visual_bell_duration 0.0

# Enable/disable the audio bell. Useful in environments that require silence.
enable_audio_bell no

# The modifier keys to press when clicking with the mouse on URLs to open the URL
open_url_modifiers ctrl+shift

# The program with which to open URLs that are clicked on. The special value "default" means to
# use the operating system's default URL handler.
open_url_with default

# The modifiers to use rectangular selection (i.e. to select text in a
# rectangular block with the mouse)
rectangle_select_modifiers ctrl+alt


# Allow other programs to control kitty. If you turn this on other programs can
# control all aspects of kitty, including sending text to kitty windows,
# opening new windows, closing windows, reading the content of windows, etc.
# Note that this even works over ssh connections.
allow_remote_control no

# The value of the TERM environment variable to set
term xterm-kitty

# The width (in pts) of window borders. Will be rounded to the nearest number of pixels based on screen resolution.
# Note that borders are displayed only when more than one window is visible. They are meant to separate multiple windows.
window_border_width 1

# The window margin (in pts) (blank area outside the border)
window_margin_width 0

# The window padding (in pts) (blank area between the text and the window border)
# top right bottom left
window_padding_width 0 5 0 5

# The color for the border of the active window
active_border_color #00ff00

# The color for the border of inactive windows
inactive_border_color #cccccc

# Fade the text in inactive windows by the specified amount (a number between
# zero and one, with 0 being fully faded).
inactive_text_alpha 1.0

# Which edge to show the tab bar on, top or bottom
tab_bar_edge bottom

# The separator between tabs in the tab bar
tab_separator " ┇"

# Tab bar colors and styles
active_tab_foreground #000
active_tab_background #eee
active_tab_font_style bold-italic
inactive_tab_foreground #444
inactive_tab_background #999
inactive_tab_font_style normal

# black
color0   #073642
color8   #002b36

# red
color1   #dc322f
color9   #cb4b16

# green
color2   #859900
color10  #586e75

# yellow
color3   #b58900
color11  #657b83

# blue
color4  #268bd2
color12 #839496

# magenta
color5   #d33682
color13  #6c71c4

# cyan
color6   #2aa198
color14  #93a1a1

# white
color7   #839496
color15 #fdf6e3

# Key mapping
# For a list of key names, see: http://www.glfw.org/docs/latest/group__keys.html
# For a list of modifier names, see: http://www.glfw.org/docs/latest/group__mods.html
#
# You can use the special action no_op to unmap a keyboard shortcut that is
# assigned in the default configuration.
#
# You can combine multiple actions to be triggered by a single shortcut, using the
# syntax below:
# map key combine <separator> action1 <separator> action2 <separator> action3 ...
# For example:
# map ctrl+shift+e combine : new_window : next_layout
# this will create a new window and switch to the next available layout

# Clipboard
map ctrl+shift+v        paste_from_clipboard
map ctrl+shift+s        paste_from_selection
map ctrl+shift+c        copy_to_clipboard
map shift+insert        paste_from_selection
# You can also pass the contents of the current selection to any program using
# pass_selection_to_program. By default, the system's open program is used, but
# you can specify your own, for example:
# map ctrl+shift+o      pass_selection_to_program firefox
map ctrl+shift+o        pass_selection_to_program

# Scrolling
#map ctrl+shift+up        scroll_line_up
#map ctrl+shift+down      scroll_line_down
#map ctrl+shift+k         scroll_line_up
#map ctrl+shift+j         scroll_line_down
#map ctrl+shift+page_up   scroll_page_up
#map ctrl+shift+page_down scroll_page_down
#map ctrl+shift+home      scroll_home
#map ctrl+shift+end       scroll_end
#map ctrl+shift+h         show_scrollback

# Window management
#map ctrl+shift+enter    new_window
#map ctrl+shift+n        new_os_window
#map ctrl+shift+w        close_window
#map ctrl+shift+]        next_window
#map ctrl+shift+[        previous_window
#map ctrl+shift+f        move_window_forward
#map ctrl+shift+b        move_window_backward
#map ctrl+shift+`        move_window_to_top
#map ctrl+shift+1        first_window
#map ctrl+shift+2        second_window
#map ctrl+shift+3        third_window
#map ctrl+shift+4        fourth_window
#map ctrl+shift+5        fifth_window
#map ctrl+shift+6        sixth_window
#map ctrl+shift+7        seventh_window
#map ctrl+shift+8        eighth_window
#map ctrl+shift+9        ninth_window
#map ctrl+shift+0        tenth_window
# You can open a new window running an arbitrary program, for example:
# map ctrl+shift+y      new_window mutt
#
# You can pass the current selection to the new program by using the @selection placeholder
# map ctrl+shift+y      new_window less @selection
#
# You can even send the contents of the current screen + history buffer as stdin using
# the placeholders @text (which is the plain text) and @ansi (which includes text styling escape codes)
# For example, the following command opens the scrollback buffer in less in a new window.
# map ctrl+shift+y      new_window @ansi less +G -R
#
# You can open a new window with the current working directory set to the
# working directory of the current window using
# map ctrl+alt+enter    new_window_with_cwd


# Tab management
#map ctrl+shift+right    next_tab
#map ctrl+shift+left     previous_tab
#map ctrl+shift+t        new_tab
#map ctrl+shift+q        close_tab
#map ctrl+shift+l        next_layout
#map ctrl+shift+.        move_tab_forward
#map ctrl+shift+,        move_tab_backward
# You can also create shortcuts to go to specific tabs, with 1 being the first tab
# map ctrl+alt+1          goto_tab 1
# map ctrl+alt+2          goto_tab 2

# Just as with new_window above, you can also pass the name of arbitrary
# commands to run when using new_tab and use new_tab_with_cwd.


# Miscellaneous
map ctrl+shift+equal    increase_font_size
map ctrl+shift+minus    decrease_font_size
map ctrl+shift+backspace restore_font_size
map ctrl+shift+f11      toggle_fullscreen
map ctrl+shift+u        input_unicode_character

# Sending arbitrary text on shortcut key presses
# You can tell kitty to send arbitrary (UTF-8) encoded text to
# the client program when pressing specified shortcut keys. For example:
# map ctrl+alt+a send_text all Special text
# This will send "Special text" when you press the Ctrl+Alt+a key combination.
# The text to be sent is a python string literal so you can use escapes like
# \x1b to send control codes or \u21fb to send unicode characters (or you can
# just input the unicode characters directly as UTF-8 text). The first argument
# to send_text is the keyboard modes in which to activate the shortcut. The possible
# values are normal or application or kitty or a comma separated combination of them.
# The special keyword all means all modes. The modes normal and application refer to
# the DECCKM cursor key mode for terminals, and kitty refers to the special kitty
# extended keyboard protocol. Another example, that outputs a word and then moves the cursor
# to the start of the line (same as pressing the Home key):
# map ctrl+alt+a send_text normal Word\x1b[H
# map ctrl+alt+a send_text application Word\x1bOH

# Symbol mapping (special font for specified unicode code points). Map the
# specified unicode codepoints to a particular font. Useful if you need special
# rendering for some symbols, such as for Powerline. Avoids the need for
# patched fonts. Each unicode code point is specified in the form U+<code point
# in hexadecimal>. You can specify multiple code points, separated by commas
# and ranges separated by hyphens. symbol_map itself can be specified multiple times.
# Syntax is:
#
# symbol_map codepoints Font Family Name
#
# For example:
#
# symbol_map U+E0A0-U+E0A2,U+E0B0-U+E0B3 PowerlineSymbols


# OS specific tweaks

# Copy to clipboard on select. With this enabled, simply selecting text with
# the mouse will cause the text to be copied to clipboard. Useful on platforms
# such as macOS/Wayland that do not have the concept of primary selections. Note
# that this is a security risk, as all programs, including websites open in your
# browser can read the contents of the clipboard.
copy_on_select no

# Hide the kitty window's title bar on macOS.
macos_hide_titlebar true

# Use the option key as an alt key. With this set to no, kitty will use
# the macOS native Option+Key = unicode character behavior. This will
# break any Alt+key keyboard shortcuts in your terminal programs, but you
# can use the macOS unicode input technique.
macos_option_as_alt yes

# The number is a percentage of maximum volume.
# See man XBell for details.
x11_bell_volume 80
