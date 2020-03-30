# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  wrapChromiumApp = { app, name }:
    pkgs.symlinkJoin {
      inherit name;
      paths = [ app ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/${name} \
          --add-flags "--force-device-scale-factor=2"
      '';
    };
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
      ./hardware-configuration.nix
      ./cachix.nix
      ./yubikey.nix
      ./ddcutil.nix
    ];




  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.overlays = [ (import ./overlays.nix config) ];

  # networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [
    "8.8.8.8"
  ];
  # networking.wireless.iwd.enable = true;
  # networking.networkmanager.extraConfig = ''
  # [device]
  # wifi.backend=iwd
  # '';



  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
      # system
      libnotify
      udiskie
      killall
      brightnessctl
      ddcutil
      s-tui

      # dev
      gnumake
      gcc
      cachix
      git
      wget
      tree
      tmux
      rofi
      htop-vim
      lm_sensors
      ag
      nix-prefetch-scripts
      unstable.nixpkgs-fmt
      fzy
      docker-compose
      (
        let
          lorri = builtins.fetchGit {
            url = "https://github.com/target/lorri.git";
            rev = "88c680c9abf0f04f2e294436d20073ccf26f0781";
          };
        in
          import lorri {}
      )
      haskellPackages.ormolu
      unstable.nodePackages.node2nix
      nodejs
      yarn
      stack
      xclip
      unstable.nodePackages.node2nix
      kitty
      unstable.idea.idea-community
      vim
      dmg2img
      unzip
      coreutils
      wget
      #unstable.electron_6


      gnupg
      gopass

      # DE / Apps
      gnome3.dconf
      arc-theme
      arc-icon-theme
      polybar
      compton
      networkmanager_dmenu
      gnome3.nautilus
      gnome3.file-roller
      peek
      capture
      nitrogen
      zoom
      mpv
      transmission_gtk
      unstable.torbrowser

      (
        wrapChromiumApp {
          name = "chromium";
          app = chromium;
        }
      )



      (
        wrapChromiumApp {
          name = "slack";
          app = unstable.slack;
        }
      )

      (
        wrapChromiumApp {
          name = "spotify";
          app = spotify;
        }
      )

      unstable.skype

      unstable.firefox

      (
        makeDesktopItem {
          name = "calendar";
          exec = "chromium --app=https://calendar.google.com";
          comment = "Google Calendar";
          desktopName = "Calendar";
        }
      )

      exiftool
      spotify

      (
        makeDesktopItem {
          name = "Notion";
          exec = "chromium --app=https://www.notion.so";
          comment = "Notion";
          desktopName = "Notion";
        }
      )

      (
        makeDesktopItem {
          name = "slack";
          exec = "slack";
          comment = ":)";
          desktopName = "Slack";
        }
      )
    ];

  # virtualisation.virtualbox = {
  #     host.enable = true;
  #     host.enableExtensionPack = true;
  #     #host.package = pkgs.unstable.virtualbox;
  # };

  virtualisation.docker = {
    enable = true;
  };

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.brightnessctl.enable = true;

  # systemd.user.services.udiskie = {
  #   enable = true;
  #   description = "udiskie to automount media";
  #   after =  ["graphical-session-pre.target"];
  #   wantedBy = ["default.target"];
  #   partOf = ["graphical-session.target"];
  #   serviceConfig = {
  #     Type="forking";
  #     Restart = "always";
  #     ExecStart = "${pkgs.udiskie}/bin/udiskie --automount --notify --no-file-manager";
  #   };
  # };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    #dpi = 210;
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
  i18n.consoleUseXkbConfig = true;

  services.localtime.enable = true;
  services.avahi.enable = true;
  services.geoclue2.enable = true;
  # services.gnome3.core-shell.enable = true;

  services.lorri.enable = true;


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

  # fonts.fontconfig.dpi = 210;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  programs.zsh.enable = true;
  users.users.gabor = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "docker" ];
  };

  nix.trustedUsers = [ "gabor" ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

  nix.extraOptions = ''
    tarball-ttl = 100000
  '';

}
