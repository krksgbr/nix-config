{
  description = "nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-legacy.url = "github:nixos/nixpkgs/nixos-20.09";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    emacs-overlay.url = "github:nix-community/emacs-overlay?rev=c939047c31f01535942826d831987154157c8d8d";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        { userName = "gabor"; }
        {
          nixpkgs.overlays =
            let
              pkgSet = pkgs:
                import pkgs {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                };
            in
            [
              (_: _:
                {
                  legacy = pkgSet inputs.nixpkgs-legacy;
                  unstable = pkgSet inputs.nixpkgs-unstable;
                })
              inputs.emacs-overlay.overlay
            ];
        }
        ./nixos/configuration.nix
        "${nixos-hardware}/lenovo/thinkpad/t490"
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
