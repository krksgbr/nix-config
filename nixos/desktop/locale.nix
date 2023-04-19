{ config, lib, pkgs, ... }:
{
  services.localtimed.enable = true;
  services.geoclue2.enable = true;
  time.timeZone = "Europe/Amsterdam";
}
