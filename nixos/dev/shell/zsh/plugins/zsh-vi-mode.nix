{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    plugins = [
      {
        name = "zsh-vim-mode";
        src = fetchGit {
          url = "https://github.com/softmoth/zsh-vim-mode.git";
          rev = "1f9953b7d6f2f0a8d2cb8e8977baa48278a31eab";
        };
      }
    ];
    sessionVariables = {
      MODE_INDICATOR = "";
    };
  };
}
