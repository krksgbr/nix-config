{ config, lib, pkgs, ... }:
{
  services.xserver = {
    displayManager.defaultSession = "none+i3";
    displayManager.gdm.enable = true;
  };
}
