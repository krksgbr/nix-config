{ config, lib, pkgs, ... }:
{
  xdg.portal.enable = true;
  services.flatpak.enable = true;


  environment.extraInit = ''
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share
  '';
}
