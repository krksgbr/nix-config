{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    plugins = [
      {
        name = "zsh-vi-mode";
        src = fetchGit {
          url = "https://github.com/jeffreytse/zsh-vi-mode.git";
          rev = "52b28837730e91780171a74069776d1558f24b1b";
        };
      }
    ];
    sessionVariables.ZVM_VI_EDITOR = "vim";
  };
}
