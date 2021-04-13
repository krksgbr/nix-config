{ config, lib, pkgs, ... }:
{
  hm = {
    home.packages = [
      (pkgs.mkScript "rofi-logout" ./rofi-logout)
      (pkgs.mkScript "rofi-kbd-layout" ./rofi-kbd-layout)
    ];

    home.file = {
      "bin/rofi-logout".source = ./rofi-logout; # expected by i3
      "bin/rofi-kbd-layout".source = ./rofi-kbd-layout; # expected by i3
    };

    programs.rofi = {
      enable = true;
      extraConfig = {
        modi = "window,drun";
        combi-modi = "window,drun";
        font = "Iosevka 24";
        fullscreen = true;
      };
      theme = ./solarized.css;
    };
  };
}
