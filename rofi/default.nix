{ config, lib, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    theme = ./solarized.css;
    extraConfig = ''
    rofi.font: Iosevka 24
    rofi.combi-modi: window,drun,ssh
    rofi.modi: combi
    rofi.fullscreen: true
    '';
  };
  home.packages = [
      (pkgs.mkScript "rofi-logout" ./rofi-logout)
      (pkgs.mkScript "rofi-kbd-layout" ./rofi-kbd-layout)
  ];
}
