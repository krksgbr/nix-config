# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  nixosHardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware.git";
    rev = "cc353d439e3135dbe3f5473d897d2c35537f260c";
  };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      "${nixosHardware}/lenovo/thinkpad/t490"
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

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.0.2u"
    ];
  };

  nixpkgs.overlays = import ./overlays.nix config;

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


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
