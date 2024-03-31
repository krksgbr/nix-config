{ config, lib, pkgs, ... }:

{
  hm = {
    home.packages = with pkgs; [
      nodejs
      nodePackages.node2nix
      yarn
      deno
      bun
    ];
    home.sessionPath = [
      "$HOME/.yarn/bin"
    ];
  };
}
