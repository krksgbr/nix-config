{ config, lib, pkgs, ... }:

{
  imports = [
    #./android.nix
    #./bluetooth.nix
    ./yubikey.nix
    ./networking.nix
    # ./connman.nix
    #./power.nix
  ];

  environment.systemPackages = with pkgs; [
      vim
      git
      coreutils
      lm_sensors
      unzip
  ];

  hm.services.udiskie.enable = true;
  users.users.gabor = {
   isNormalUser = true;
   extraGroups = ["wheel"];
  };

}
