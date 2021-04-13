{ config, lib, pkgs, ... }:
{
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hm.home.packages = [ pkgs.pavucontrol ];
}
