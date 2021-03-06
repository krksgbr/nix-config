{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    plugins = [
      {
        name = "zsh-vi-mode";
        src = fetchGit {
          url = "https://github.com/jeffreytse/zsh-vi-mode.git";
          rev = "2cdeb68d5eab63a8bd951aec52bb407b8445fb1a";
        };
      }
    ];
    sessionVariables = {
      ZVM_VI_EDITOR = "vim";
      ZVM_LINE_INIT_MODE = "$ZVM_MODE_INSERT";
      ZVM_VI_HIGHLIGHT_BACKGROUND = "black";
    };

    initExtra = ''
      function zvm_after_lazy_keybindings() {
         if [[ -n $HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND ]]; then
             zvm_bindkey vicmd 'k' history-substring-search-up
             zvm_bindkey vicmd 'j' history-substring-search-down
         fi

         zvm_define_widget command-history
         zvm_bindkey vicmd '/' command-history
      }
    '';
  };
}
