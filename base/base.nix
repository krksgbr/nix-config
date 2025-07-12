{home-manager-modules}: {
  system,
  pkgs,
  hostName,
  ...
}: {
  imports = [
    ./user-alias.nix
    (import ./home-manager.nix {inherit home-manager-modules;})
    ./konfigue.nix
  ];
  nixpkgs.hostPlatform = system;
  nix.settings.experimental-features = "nix-command flakes";
  programs.zsh.enable = true;
  networking.hostName = hostName;
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
}
