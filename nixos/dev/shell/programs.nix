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

    home.packages = with pkgs; [
      binutils
      coreutils
      dmg2img
      exiftool
      gopass
      gnupg
      killall
      nix-prefetch-scripts
      ncdu
      ripgrep
      unzip
      wget
      xclip
      cachix
      ffmpeg
      gcc
      gnumake
      html-tidy
      procs
      python3
      nixpkgs-fmt
      rsync
      rmapi
      jq
      git-crypt
      sad
      fd
      exa
      cheat
      tldr
      bat
      nix-env-clean
      choose
    ];

    programs.htop = {
      enable = true;
    };
  };
}
