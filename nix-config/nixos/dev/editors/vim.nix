{ config, lib, pkgs, ... }:
{
  hm.programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
    plugins = with pkgs.vimPlugins; [
      sensible
      surround
      airline
      solarized
      tmux-navigator
      vim-tmux-navigator
    ];
  };
}
