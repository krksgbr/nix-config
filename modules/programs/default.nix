{ config, lib, pkgs, ... }:
{
  imports = [
    ../shell/options.nix
    ./bat
    ./direnv
    ./exa
    ./fzf
    ./git
    ./kitty
    ./neovim
    ./tmux
  ];

  hm.home.packages = with pkgs; [
    jq
    curl
    imagemagick
  ];
}
