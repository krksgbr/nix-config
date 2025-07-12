{
  system,
  configuration,
  legacy,
  unstable,
  stateVersion,
  home-manager-modules,
  inputs,
  hostName,
  ...
}: {
  inherit system;
  modules = [
    (import ./overlays.nix {
      inherit legacy;
      inherit unstable;
      inherit inputs;
    })
    (import ./base.nix {
      inherit home-manager-modules;
    })
    configuration
    ./konfigue.nix
  ];
  specialArgs = {
    inherit system;
    inherit stateVersion;
    inherit inputs;
    inherit hostName;
  };
}
