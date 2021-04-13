{ config, lib, pkgs, ... }:
{
  imports = [ ./polybar
              ./networkmanager-dmenu
              ./rofi
            ];
  hm = {
    home.packages = with pkgs; [ brightnessctl nitrogen ];

    xsession.windowManager.i3 = {
      enable = true;
      extraConfig = builtins.readFile ./config;
      config.bars = [ ];
      config.modifier = "Mod4";
      config.keybindings = { };
    };

    xsession.enable = true;
    xsession.pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ-AA";
      size = 128;
    };

    xresources.extraConfig = ''
      Xft.dpi: 210
    '';

    services.picom = {
      enable = true;
      backend = "glx";
      experimentalBackends = true;
      vSync = true;
      extraOptions = ''
        glx-no-stencil = true;
      '';
    };
  };

  services.xserver.windowManager.i3.enable = true;
}
