{ config, lib, pkgs, ... }:

{
  hm = {
    home.file.".config/networkmanager-dmenu/config.ini".source = ./config.ini;
    home.packages = with pkgs; [ networkmanager_dmenu ];
  };
}
