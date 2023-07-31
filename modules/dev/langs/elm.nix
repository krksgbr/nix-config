{ config, lib, pkgs, ... }:
{
  hm.home.packages = with pkgs.elmPackages; [
    elm
    elm-format
    elm-test
    elm-language-server
  ];
}
