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
      tree
      unzip
      wget
      xclip
      cachix
      ffmpeg
      gcc
      gnumake
      html-tidy
      python3
      nixpkgs-fmt
      rsync
      rmapi
      jq
      git-crypt
    ];

    programs.htop = {
      enable = true;
    };
  };
}
