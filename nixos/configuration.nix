# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./cachix.nix
      ./desktop-environment.nix
      ./hardware-configuration.nix
      ./networking.nix
      ./peripherals/android.nix
      ./peripherals/bluetooth.nix
      ./peripherals/ddcutil.nix
      ./peripherals/udiskie.nix
      ./peripherals/yubikey.nix
      ./programs/apps.nix
      ./programs/dev-tools.nix
      ./users.nix
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "slack"
    "zoom"
    "spotify"
    "spotify-unwrapped"
    "joypixels"
  ];

  nixpkgs.overlays = import ./overlays.nix config inputs;

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

      exiftool
    ];

  services.openssh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  location.longitude = 4.3007;
  location.latitude = 52.0705;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
