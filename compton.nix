{ config, lib, pkgs, ... }:
{
  services.compton = {
    enable = true;
    backend = "glx";
    vSync = "opengl-swc";
    extraOptions = ''
      paint-on-overlay = true;
    '';
  };
}
