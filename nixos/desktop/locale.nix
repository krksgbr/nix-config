{ config, lib, pkgs, ... }:
{
  services.localtime.enable = true;
  services.geoclue2.enable = true;
  time.timeZone = "Europe/Amsterdam";
}
