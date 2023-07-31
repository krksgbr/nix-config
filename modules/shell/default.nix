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



  hm = {
    home.packages = with pkgs; [
      # ranger
      # xplr
      # bat
      # binutils
      # cachix
      # cheat
      # colmena
      # choose
      # coreutils
      # dmg2img
      # exa
      # exiftool
      # fd
      # ffmpeg
      # gcc
      # git-crypt
      # gnumake
      # gnupg
      # gopass
      # html-tidy
      # jq
      # killall
      # lsof
      # ncdu
      # nix-env-clean
      # nix-prefetch-scripts
      # nixpkgs-fmt
      # morph
      # ocamlformat
      # ouch
      # poppler_utils
      # procs
      # python3
      # ripgrep
      # rmapi
      # rsync
      # #sad
      # sqlite
      # tldr
      # unzip
      # wget
      # xclip
      #
      # lilypond
      # fluidsynth
      # midicsv
    ];
  };
}
