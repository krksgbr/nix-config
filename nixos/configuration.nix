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
      polybar
      compton
      networkmanager_dmenu
      nitrogen
      exiftool
      kde-gtk-config
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

     desktopManager.plasma5.enable = true;
     displayManager.sddm.enable = true;
     desktopManager.xterm.enable = false;
   };

  # This will apply the X keymap to the console keymap,
  # which affects virtual consoles such as tty
  # https://unix.stackexchange.com/questions/377600/in-nixos-how-to-remap-caps-lock-to-control
  console.useXkbConfig = true;

  services.localtime.enable = true;
  services.geoclue2.enable = true;

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


}
