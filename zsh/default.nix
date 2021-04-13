{ config, pkgs, ... }:
let
  zshrc = builtins.readFile ./zshrc;
  shellsCommon = import ../shells-common.nix;
in
{
  imports = [
    ./plugins/enhancd.nix
    ./plugins/pure.nix
    ./plugins/zaw.nix
    ./plugins/zsh-completions.nix
    ./plugins/zsh-history-substring-search.nix
    ./plugins/zsh-vi-mode.nix
  ];

  programs.zsh = {
    enable = true;
    initExtraBeforeCompInit = ''
      fpath+="$HOME/.zsh/functions"
      fpath+="$HOME/.zsh/completions"
    '';
    initExtra =
      let
        PATH = builtins.concatStringsSep ":" [
          "$HOME/.emacs.d/bin"
          "$HOME/.yarn/bin"
        ];
      in
      ''
        ${zshrc}
        export PATH="${PATH}:$PATH"
        [ -z $TMUX ] && (tmux a &> /dev/null || tmux)
      '';
    sessionVariables = shellsCommon.sessionVariables
      // {
      KEY_TIMEOUT = "10";
      LS_COLORS = "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43";
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "bg=magenta,fg=black,bold";
    }
    ;
    shellAliases = shellsCommon.shellAliases;
  };
}
