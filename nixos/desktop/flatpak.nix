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



  ### Let flatpak apps access system fonts
  ### https://github.com/NixOS/nixpkgs/issues/119433#issuecomment-1326957279
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
      };
      aggregatedFonts = pkgs.buildEnv {
        name = "system-fonts";
        paths = config.fonts.fonts;
        pathsToLink = [ "/share/fonts" ];
      };
    in
    {
      # Create an FHS mount to support flatpak host icons/fonts
      "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
      "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
    };
}
