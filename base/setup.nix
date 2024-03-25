{ system
, configuration
, legacy
, stable
, unstable
, stateVersion
, home-manager-modules
, inputs
, hostName
}: {
  inherit system;
  modules = [
    (import ./overlay-pkg-sets.nix { inherit legacy; inherit unstable; })
    (import ./base.nix {
      inherit home-manager-modules;
    })
    ./nix-scripts.nix
    configuration
  ];
  specialArgs = {
    inherit system;
    inherit stateVersion;
    inherit inputs;
    inherit hostName;
    myLib = import ./myLib.nix { lib = stable.lib; };
  };
}
