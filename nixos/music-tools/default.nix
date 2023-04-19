{ config, lib, pkgs, ... }:
{
  imports = [
    ./bandcamp-dl.nix
  ];

  hm.home.packages = with pkgs; [
    sox
    kid3
  ];
}
