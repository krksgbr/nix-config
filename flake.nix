{
  description = "nixos";

  inputs = {
    nixpkgs-legacy.url = "github:nixos/nixpkgs/nixos-20.09";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
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
                  stable = pkgSet inputs.nixpkgs-stable;
                  legacy = pkgSet inputs.nixpkgs-legacy;
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
