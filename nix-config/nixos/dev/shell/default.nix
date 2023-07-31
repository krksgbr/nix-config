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

  hm = {

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
