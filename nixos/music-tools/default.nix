{ config, lib, pkgs, ... }:
{
  imports = [
    ./bandcamp-dl.nix
  ];

  hm.home.packages = with pkgs; [
    beets
    sox
    kid3
  ];

  hm.xdg.configFile."beets/config.yaml".text = ''
    plugins: discogs
  '';
}
