{
  description = "Mi Konfigue";
  inputs = {

    ## Universal unstable channel
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    ## Darwin
    darwin-stable.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    darwin-legacy.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    home-manager-darwin = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "darwin-stable";
    };
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "darwin-stable";
    };


    ## Linux
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-legacy.url = "github:NixOS/nixpkgs/nixos-22.05";
    home-manager-nixos = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixos-stable";
    };
  };

  outputs = inputs@{ self, nix-darwin, ... }:
    let
      setup = import ./base/setup.nix;
    in
    {
      darwinConfigurations."krks-mbp" = nix-darwin.lib.darwinSystem (setup {
        system = "aarch64-darwin";
        configuration = ./hosts/mac/configuration.nix;
        legacy = inputs.darwin-legacy;
        stable = inputs.darwin-stable;
        unstable = inputs.nixpkgs-unstable;
        stateVersion = "23.11";
        home-manager-modules = inputs.home-manager-darwin.darwinModules.home-manager;
        hostName = "krks-mbp";
        inherit inputs;
      });

      # Expose the darwin package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."krks-mbp".pkgs;

      nixosConfigurations.flakey =
        with inputs.nixos-stable;
        lib.nixosSystem
          (setup {
            system = "aarch64-linux";
            configuration = ./hosts/flakey/configuration.nix;
            legacy = inputs.nixos-legacy;
            stable = inputs.nixos-stable;
            unstable = inputs.nixos-unstable;
            stateVersion = "23.11";
            home-manager-modules = inputs.home-manager-nixos.nixosModules.home-manager;
            hostName = "flakey";
            inherit inputs;
          });
    };
}
