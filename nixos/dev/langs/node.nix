{ config, lib, pkgs, ... }:

{
  hm = {
    home.packages = with pkgs; [
      nodejs
      nodePackages.node2nix
      yarn
    ];
    home.sessionPath = [
      "$HOME/.yarn/bin"
    ];
  };
}
