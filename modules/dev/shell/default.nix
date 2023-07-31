{ config, lib, pkgs, ... }:
let
  nix-env-clean = pkgs.writeShellScriptBin "nix-env-clean" ''
    nix-env -q | fzf --height 40% -m --reverse | xargs nix-env --uninstall
  '';
in
{
  imports = [
    ./options.nix
    ./zsh
  ];

  my.shell.sessionVariables = {
    EDITOR = "nvim";
    GPG_TTY = "$(tty)";
  };

  hm.programs.bash = {
    enable = true;
    shellAliases = config.my.shell.aliases;
    sessionVariables = config.my.shell.sessionVariables;
    bashrcExtra = ''
      set -o vi
    '';
  };
}
