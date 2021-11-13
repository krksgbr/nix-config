{ config, lib, pkgs, ... }:

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
    ];

    programs.htop = {
      enable = true;
    };
  };
}
