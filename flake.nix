{
  description = "nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=c5ed8beb478a8ca035f033f659b60c89500a3034";
    nixpkgs-legacy.url = "github:nixos/nixpkgs/nixos-20.09";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    emacs-overlay.url = "github:nix-community/emacs-overlay?rev=209234286d219ca9990707a1f2377e731048bbd2";
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
