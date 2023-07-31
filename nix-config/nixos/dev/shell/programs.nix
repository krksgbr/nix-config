{ config, lib, pkgs, ... }:
let
  nix-env-clean = pkgs.writeShellScriptBin "nix-env-clean" ''
    nix-env -q | fzf --height 40% -m --reverse | xargs nix-env --uninstall
  '';
in
{
  hm = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.pistol.enable = true;
    programs.zsh.initExtra = ''
      export PISTOL_CHROMA_STYLE=solarized-dark

      # Base16 Solarized Dark
      # Scheme author: Ethan Schoonover (modified by aramisgithub)
      # Template author: Tinted Theming (https://github.com/tinted-theming)

      _gen_fzf_default_opts() {

      local color00='#002b36'
      local color01='#073642'
      local color02='#586e75'
      local color03='#657b83'
      local color04='#839496'
      local color05='#93a1a1'
      local color06='#eee8d5'
      local color07='#fdf6e3'
      local color08='#dc322f'
      local color09='#cb4b16'
      local color0A='#b58900'
      local color0B='#859900'
      local color0C='#2aa198'
      local color0D='#268bd2'
      local color0E='#6c71c4'
      local color0F='#d33682'

      export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
      " --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
      " --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
      " --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

      }

      _gen_fzf_default_opts
    '';

    home.packages = with pkgs; [
      ranger
      xplr
      bat
      binutils
      cachix
      cheat
      colmena
      choose
      coreutils
      dmg2img
      exa
      exiftool
      fd
      ffmpeg
      gcc
      git-crypt
      gnumake
      gnupg
      gopass
      html-tidy
      jq
      killall
      lsof
      ncdu
      nix-env-clean
      nix-prefetch-scripts
      nixpkgs-fmt
      morph
      ocamlformat
      ouch
      poppler_utils
      procs
      # python3
      ripgrep
      rmapi
      rsync
      #sad
      sqlite
      tldr
      unzip
      wget
      xclip

      lilypond
      fluidsynth
      midicsv
    ];

    programs.htop = {
      enable = true;
    };
  };
}
