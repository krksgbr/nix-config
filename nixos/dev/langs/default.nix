{ config, lib, pkgs, ... }:
{
  imports = [
    ./elm.nix
    ./haskell.nix
    ./node.nix
  ];
}
