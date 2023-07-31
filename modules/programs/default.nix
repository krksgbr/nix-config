{ config, lib, pkgs, ... }:
{
  imports = [
    ../shell/options.nix
    ./bat
    ./direnv
    ./exa
    ./fzf
    ./git
    # ./kitty
    ./neovim
    ./tmux
  ];
}
