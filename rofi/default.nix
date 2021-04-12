{ config, lib, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "window,drun,ssh";
      font = "Iosevka 24";
      fullscreen = true;
    };
    theme = ./solarized.css;
  };
  home.packages = [
    (pkgs.mkScript "rofi-logout" ./rofi-logout)
    (pkgs.mkScript "rofi-kbd-layout" ./rofi-kbd-layout)
  ];
}
