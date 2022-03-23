{ config, lib, pkgs, ... }:
{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
  services.flatpak.enable = true;


  environment.extraInit = ''
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share
  '';
}
