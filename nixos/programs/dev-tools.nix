{ pkgs, ... }:
let
  idea_launcher = pkgs.writeShellScriptBin "dea" ''
    idea-community $1 > /dev/null 2>&1 & disown;
  '';
in
{
  environment.systemPackages = with pkgs;
    [
      ag
      binutils
      cachix
      cabal-install
      coreutils
      dmg2img
      docker-compose
      elmPackages.elm
      elmPackages.elm-format
      ffmpeg
      fzy
      gcc
      git
      (pkgs.mkScript "git-recent" ./dev-tools/git-recent)
      gnumake
      haskellPackages.ormolu
      html-tidy
      htop-vim
      kitty
      nix-prefetch-scripts
      nodejs
      ncdu
      python3
      ripgrep
      rofi
      stack
      tmux
      tree
      stable.idea.idea-community
      idea_launcher
      nixpkgs-fmt
      nodePackages.node2nix
      unzip
      vim
      wget
      xclip
      yarn
    ];

  programs.zsh.enable = true;

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
}
