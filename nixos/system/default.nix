{ config, lib, pkgs, ... }:

{
  imports = [
    ./android.nix
    ./bluetooth.nix
    ./yubikey.nix
    ./networking.nix
    # ./connman.nix
    ./power.nix
  ];

  environment.systemPackages = with pkgs; [
      vim
      git
      coreutils
      lm_sensors
      unzip
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hm.services.udiskie.enable = true;

}
