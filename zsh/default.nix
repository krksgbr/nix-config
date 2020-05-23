{ config, pkgs, ... }:
let
  pureSrc = builtins.fetchGit {
    url = "https://github.com/sindresorhus/pure.git";
    rev = "42d3b83647e6bc9ce9767f6f805ee054fd9710cf";
  };
  zshrc = builtins.readFile ./zshrc;
  shellsCommon = import ../shells-common.nix;
in
{
  home.file = {
    ".zsh/functions/prompt_pure_setup".source = "${pureSrc}/pure.zsh";
    ".zsh/functions/async".source = "${pureSrc}/async.zsh";
  };
  programs.zsh = {
    enable = true;
    initExtraBeforeCompInit = ''
      fpath+="$HOME/.zsh/functions"
      fpath+="$HOME/.zsh/completions"
    '';
    initExtra =
      let
        PATH = builtins.concatStringsSep ":" [
          "$HOME/bin"
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
           HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=magenta,fg=black,bold";
           ENHANCD_HYPHEN_ARG="=";
           ENHANCD_DOT_ARG=".";
         }
      ;
    shellAliases = shellsCommon.shellAliases;
    plugins = with builtins;
      [
        {
          name = "pure";
          src = pureSrc;
        }
        {
          name = "zsh-vim-mode";
          src = fetchGit {
            url = "https://github.com/sharat87/zsh-vim-mode.git";
            rev = "49646e72cb174491a2947ab97ede1fbdace8396b";
          };
        }
        {
          name = "zsh-completions";
          src = fetchGit {
            url = "https://github.com/zsh-users/zsh-completions.git";
            rev = "b512d57b6d0d2b85368a8068ec1a13288a93d267";
          };
        }
        {
          name = "zsh-history-substring-search";
          src = fetchGit {
            url = "https://github.com/zsh-users/zsh-history-substring-search.git";
            rev = "0f80b8eb3368b46e5e573c1d91ae69eb095db3fb";
          };
        }
        { name = "zsh-yarn-autocompletions";
          src = fetchGit {
            url = "https://github.com/g-plane/zsh-yarn-autocompletions.git";
            rev = "1a46e038b95a986d651d97f5992093484a9af9ee";
          };
        }
        {
          name = "zaw";
          src = fetchGit {
            url = "https://github.com/zsh-users/zaw.git";
            rev = "c8e6e2a4244491a2b89c2524a2030336be8d7c7f";
          };
        }
        {
          name = "enhancd";
          file = "init.sh";
          src = fetchGit {
            url = "https://github.com/b4b4r07/enhancd.git";
            rev = "2ccdacae00750766c13e0b1319c8881dc626d3ec";
          };
        }
      ];
  };
}
