{ config, lib, pkgs, ... }:

with pkgs;
{
  hm.home.packages = [
    reckon
    file # reckon's dep
    unstable.hledger
  ];
}
