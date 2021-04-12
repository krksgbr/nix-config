{
  description = "nixos";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-20.09";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/configuration.nix
        "${nixos-hardware}/lenovo/thinkpad/t490"
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.gabor = import ./home.nix;
        }
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
