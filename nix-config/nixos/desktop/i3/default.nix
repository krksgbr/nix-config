{ config, lib, pkgs, ... }:
{
  imports = [
    ./polybar
    #./networkmanager-dmenu
    ./rofi
  ];

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = true;
    };
    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "gabor";
    };
    windowManager = {
      i3.enable = true;
    };
    libinput.enable = true;
  };

  hm = {
    xsession.enable = true;
    home.packages = with pkgs; [ nitrogen ];

    # xsession.windowManager.i3 = {
    #   enable = true;
    #   extraConfig = builtins.readFile ./config;
    #   config.bars = [ ];
    #   config.modifier = "Mod4";
    #   config.keybindings = { };
    # };

    home.file.".config/i3/config".source = ./config;
    home.pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ-AA";
      size = 128;
      x11.enable = true;
    };

    xresources.extraConfig = ''
      Xft.dpi: 226
    '';
  };
}
