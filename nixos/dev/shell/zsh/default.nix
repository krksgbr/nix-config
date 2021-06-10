{ config, pkgs, ... }:
{
  hm = {
    imports = [
      ./plugins/enhancd.nix
      ./plugins/zsh-completions.nix
      ./plugins/zsh-history-substring-search.nix
      ./plugins/zsh-vi-mode.nix
    ];

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = "$directory$git_branch$git_commit$git_status$git_state$nix_shell\n$character";
        git_branch = {
          format = "[| $branch]($style)";
          style = "bright-green";
        };
        git_status = {
          format = "$ahead_behind$modified$untracked$staged";
          ahead = "[ ⇡](green)";
          behind = "[ ⇣](green)";
          diverged = "[ ⇕](yellow)";
          modified = "[*](bright-green)";
          untracked = "[*](red)";
          staged = "[+](green)";
        };
        git_commit = {
          style = "yellow";
          format = " [\\($hash\\)]($style) [\\($tag\\)]($style)";
        };
        git_state = {
          format = " \([$state( $progress_current/$progress_total)]($style)\)";
        };
        nix_shell = {
          format = " [|](bright-green) [❄]($style)";
          style = "bright-green";
        };
      };
    };

    programs.zsh = {
      enable = true;
      initExtraBeforeCompInit = ''
        fpath+="$HOME/.zsh/functions"
        fpath+="$HOME/.zsh/completions"
      '';
      initExtra =
        let
          zshrc =
            builtins.readFile ./zshrc;
          fzf = "${pkgs.fzf}/bin/fzf --height 40%";
        in
        ''
          function command-history {
             BUFFER="$(history -100 | awk '{$1=""}1' | ${fzf} --tac)"
             zle reset-prompt
          }

          function kill9 {
            local pid
            pid=$(ps -f -u $UID | sed 1d | ${fzf} -m | awk '{print $2}')
            if [ "x$pid" != "x" ]; then
              BUFFER="kill -9 $pid"
              zle reset-prompt
            fi
          }
          zle -N kill9
          bindkey -M vicmd ' p' kill9
          ${zshrc}

        '';
      sessionVariables = config.my.shell.sessionVariables
        // {
        KEY_TIMEOUT = "10";
        LS_COLORS = "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43";
      }
      ;
      shellAliases = config.my.shell.aliases;
    };
  };
}
