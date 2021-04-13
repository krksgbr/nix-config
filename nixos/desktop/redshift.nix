{ config, lib, pkgs, ... }:
{
  hm.services.redshift = {
    enable = true;
    provider = "geoclue2";
    tray = true;
    temperature.day = 6500;
    temperature.night = 2000;
  };
}
