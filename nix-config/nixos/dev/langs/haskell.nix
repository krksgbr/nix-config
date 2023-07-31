{ config, lib, pkgs, ... }:

{
  hm.home.packages = with pkgs; [
      haskellPackages.ormolu
      cabal-install
      stack
  ];
}
