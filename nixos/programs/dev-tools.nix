{ pkgs, ... }:
let
  lorri = (
    let
      lorri_ = builtins.fetchGit {
        url = "https://github.com/target/lorri.git";
        rev = "88c680c9abf0f04f2e294436d20073ccf26f0781";
      };
    in
      import lorri_ {}
  );

  idea_launcher = pkgs.writeShellScriptBin "dea" ''
  idea-community $1 > /dev/null 2>&1 & disown;
  '';
in
{
  environment.systemPackages = with pkgs;
    [
      ag
      cachix
      cabal-install
      coreutils
      dmg2img
      docker-compose
      fzy
      gcc
      git
      (import ./dev-tools/git-recent.nix { inherit pkgs; })
      gnumake
      haskellPackages.ormolu
      htop-vim
      kitty
      lorri
      nix-prefetch-scripts
      nodejs
      ripgrep
      rofi
      stack
      tmux
      tree
      unstable.idea.idea-community
      idea_launcher
      unstable.nixpkgs-fmt
      unstable.nodePackages.node2nix
      unzip
      vim
      wget
      xclip
      yarn
    ];

  programs.zsh.enable = true;
  services.lorri.enable = true;
  virtualisation.docker = {
    enable = true;
  };
}
