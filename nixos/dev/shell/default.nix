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
    nrs = ''cd $HOME/nix-config/ && sudo nix-shell shell.nix --command "sudo nixos-rebuild switch --flake '.#'" && cd -'';
    nrt = ''cd $HOME/nix-config/ && sudo nix-shell shell.nix --command "sudo nixos-rebuild test --flake '.#'" && cd -'';
    ls = "exa";
    grep = "grep --color=always";
    clip = "xclip -selection clipboard";
    mkinvoice = "node ~/projects/invoicer/run.js";
    tree = "exa --tree";
    cat = ''bat --theme="Solarized (dark)"'';
  };

  my.shell.sessionVariables = {
    EDITOR = "vim";
    GPG_TTY = "$(tty)";
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
