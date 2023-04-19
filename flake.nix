{
  description = "nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-legacy.url = "github:nixos/nixpkgs/nixos-20.09";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    emacs-overlay.url = "github:nix-community/emacs-overlay?rev=c939047c31f01535942826d831987154157c8d8d";

    # Terminal file manager
    xplr.url = "github:sayanarijit/xplr?rev=b995be0089f0fe9723abcb71a8dfaf4fed17a0f4";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        { userName = "gabor"; }
        {
          nixpkgs.overlays =
            let
              pkgSet = pkgs:
                import pkgs {
                  system = "aarch64-linux";
                  config.allowUnfree = true;
                };
            in
            [
              (_: _:
                {
                  legacy = pkgSet inputs.nixpkgs-legacy;
                  unstable = pkgSet inputs.nixpkgs-unstable;
                  xplr = inputs.xplr.defaultPackage.${"aarch64-linux"}.overrideAttrs (final: prev: {
                    checkFlags = [
                      # reason for disabling test
                      "--skip=path::tests::test_relative_to_parent"
                    ];
                  });
                })
              inputs.emacs-overlay.overlay
            ];
        }
        ./nixos/configuration.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
