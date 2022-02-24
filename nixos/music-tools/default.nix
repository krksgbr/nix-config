{ config, lib, pkgs, ... }:
{
  imports = [
    ./bandcamp-dl.nix
  ];

  hm.home.packages = [
    pkgs.beets
    pkgs.sox
  ];

  hm.xdg.configFile."beets/config.yaml".text = ''
    plugins: discogs
  '';
}
