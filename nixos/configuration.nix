# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  nixosHardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware.git";
    rev = "ed0d3cc198557b9260295aa8a384dd5080706aee";
  };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      "${nixosHardware}/lenovo/thinkpad/t490"
      ./cachix.nix
      ./hardware-configuration.nix
      ./networking.nix
      ./peripherals/ddcutil.nix
      ./peripherals/udiskie.nix
      ./peripherals/yubikey.nix
      ./peripherals/android.nix
      ./programs/apps.nix
      ./programs/dev-tools.nix
      ./users.nix
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.0.2u"
    ];
  };

  nixpkgs.overlays = [ (import ./overlays.nix config) ];

  environment.systemPackages = with pkgs;
    [
      # system
      libnotify
      killall
      brightnessctl
      s-tui
      lm_sensors
      gnupg
      gopass

      # DE
      gnome3.dconf
      arc-theme
      arc-icon-theme
      polybar
      compton
      networkmanager_dmenu
      gnome3.nautilus
      gnome3.file-roller
      nitrogen

      exiftool
    ];

  # virtualisation.virtualbox = {
  #     host.enable = true;
  #     host.enableExtensionPack = true;
  #     #host.package = pkgs.unstable.virtualbox;
  # };

  environment.pathsToLink = [ "/share/zsh" ];
  environment.sessionVariables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };
  environment.extraInit = ''
    # these are the defaults, but some applications need these to be set explicitly
    export XDG_CONFIG_HOME=$HOME/.config
    export XDG_DATA_HOME=$HOME/.local/share
    export XDG_CACHE_HOME=$HOME/.cache
  '';

  services.openssh.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.dconf.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e, ctrl:nocaps";

    # Enable touchpad support.
    libinput.enable = true;
    libinput.naturalScrolling = true;
    libinput.accelSpeed = "1.0";

    # Configure window/desktop manager
    displayManager.lightdm.enable = true;
    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = "gabor";
      extraConfig = ''
        [greeter]
        show-password-label = true
        password-label-text = Pass:
        invalid-password-text = Nope

        [greeter-hotkeys]
        # "alt", "control" or "meta"
        mod-key = meta

        # Power management shortcuts (single-key, case-sensitive)
        shutdown-key = s
        restart-key = r
        hibernate-key = h
        suspend-key = u

        [greeter-theme]
        # A color from X11's `rgb.txt` file, a quoted hex string(`"#rrggbb"`) or a
        # RGB color(`rgb(r,g,b)`) are all acceptable formats.

        # The font to use for all text
        font = "Iosevka"
        # The font size to use for all text
        font-size = 1.25em
        # The default text color
        text-color = "#d33682"
        # The color of the error text
        error-color = "#d33682"
        # An absolute path to an optional background image.
        # The image will be displayed centered & unscaled.
        background-image = ""
        # The screen's background color.
        background-color = "#073642"
        # The password window's background color
        window-color = "#002b36"
        # The color of the password window's border
        border-color = "#002b36"
        # The width of the password window's border.
        # A trailing `px` is required.
        border-width = 2px
        # The pixels of empty space around the password input.
        # Do not include a trailing `px`.
        layout-space = 15
        # The color of the text in the password input.
        password-color = "#d33682"
        # The background color of the password input.
        password-background-color = "#073642"
      '';
    };

    desktopManager.xterm.enable = false;
    windowManager.i3.enable = true;
  };

  # This will apply the X keymap to the console keymap,
  # which affects virtual consoles such as tty
  # https://unix.stackexchange.com/questions/377600/in-nixos-how-to-remap-caps-lock-to-control
  console.useXkbConfig = true;

  services.localtime.enable = true;
  services.geoclue2.enable = true;
  # services.gnome3.core-shell.enable = true;

  time.timeZone = "Europe/Amsterdam";

  fonts.enableDefaultFonts = false;

  fonts.fonts = with pkgs; [
    liberation_ttf_v2
    iosevka
    joypixels
    ibm-plex
  ];

  fonts.fontconfig.defaultFonts = {
    emoji = [ "JoyPixels" ];
    sansSerif = [ "IBM Plex Sans" ];
    serif = [ "IBM Plex Serif" ];
    monospace = [ "Iosevka" ];
  };


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

  nix.extraOptions = ''
    tarball-ttl = 100000
  '';

}
