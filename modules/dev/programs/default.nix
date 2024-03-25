{ config, lib, pkgs, ... }:
{
  imports = [
    ../shell/options.nix
    ./bat
    ./direnv
    ./eza
    ./fzf
    ./git
    ./kitty
    ./neovim
    ./tmux
    ./zellij
  ];

  hm.home.packages = with pkgs; [
    jq
    curl
    imagemagick
    procs
  ];
}
