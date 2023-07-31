{ config, lib, pkgs, ... }:
{
  hm.services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 52.078663;
    longitude = 4.288788;
    tray = true;
    temperature.day = 6500;
    temperature.night = 2000;
  };
  services.geoclue2.enable = true;
}
