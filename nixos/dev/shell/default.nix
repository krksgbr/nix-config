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
    ls = "ls --color=auto";
    grep = "grep --color=always";
    clip = "xclip -selection clipboard";
    mkinvoice = "node ~/projects/invoicer/run.js";
  };

  my.shell.sessionVariables = {
    EDITOR = "vim";
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
      enableNixDirenvIntegration = true;
    };

  };
}
