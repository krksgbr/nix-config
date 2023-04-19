{ config, lib, pkgs, ... }:
{
  imports = [
    ./options.nix
    ./git
    ./zsh
    ./tmux
    ./programs.nix
  ];

  my.shell.aliases = {
    nrs = ''cd $HOME/nix-config/ && sudo nixos-rebuild switch --flake '.#' && cd -'';
    nrt = ''cd $HOME/nix-config/ && sudo nixos-rebuild test --flake '.#' && cd -'';
    ls = "exa";
    grep = "grep --color=always";
    clip = "xclip -selection clipboard";
    mkinvoice = "node ~/projects/invoicer/run.js";
    tree = "exa --tree";
    cat = ''bat --theme="Solarized (dark)"'';
    open = "xdg-open";
    # nvim = "TERM=xterm-kitty nvim";
  };

  my.shell.sessionVariables = {
    EDITOR = "nvim";
    GPG_TTY = "$(tty)";
    MY_IP =
      let
        grep = "grep --color=never";
      in
        ''$(ifconfig enp0s1 | ${grep} -Eo "inet (addr:)?([0-9]*\.){3}[0-9]*" | ${grep} -Eo "([0-9]*\.){3}[0-9]*" | ${grep} -v "127.0.0.1")'';
  };

  hm = {
    programs.bash = {
      enable = true;
      shellAliases = config.my.shell.aliases;
      sessionVariables = config.my.shell.sessionVariables;
      bashrcExtra = ''
        set -o vi
      '';
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
