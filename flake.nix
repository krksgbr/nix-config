{
  description = "Example Darwin system flake";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
      home-manager.url = "github:nix-community/home-manager/release-23.05"; 
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs"; 
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, ... }:
  {
    darwinConfigurations."krks-mbp" = nix-darwin.lib.darwinSystem {
      modules = [
        ./setup/user-alias.nix
        inputs.home-manager.darwinModules.home-manager
        (import ./setup/home-manager.nix { stateVersion = "23.05"; })
        ./hosts/krks-mbp/default.nix
       ];
      system = "aarch64-darwin";
      specialArgs = { inherit inputs; isDarwin = true; };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."krks-mbp".pkgs;
  };
}
