{ config, lib, pkgs, isDarwin, ... }:

{
  hm = {
    home.packages = with pkgs; if isDarwin then [ reattach-to-user-namespace ] else [ ];
    programs.tmux = {
      enable = true;
      keyMode = "vi";
      prefix = "C-a";
      plugins = with pkgs.tmuxPlugins; [
        sensible
        pain-control
        yank
      ];
      extraConfig =
        let
          defaults =
            builtins.readFile ./tmux.conf;
        in
        ''
          ${defaults}
          ${if isDarwin then ''set-option -g default-command "reattach-to-user-namespace -l ''${SHELL}"'' else "" }
        '';
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
