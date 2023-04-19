{ config, lib, pkgs, ... }:

{
  hm = {
    programs.tmux = {
      enable = true;
      keyMode = "vi";
      prefix = "C-a";
      plugins = with pkgs.tmuxPlugins; [
        sensible
        pain-control
        yank
      ];
      extraConfig = builtins.readFile ./tmux.conf;
      # extraConfig = ''
      #   bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
      #   source-file /home/gabor/nix-config/nixos/dev/shell/tmux/tmux.conf
      # '';
    };

    programs.zsh.initExtra = ''
      [ -z $TMUX ] && (tmux a &> /dev/null || tmux)
    '';
  };
}
