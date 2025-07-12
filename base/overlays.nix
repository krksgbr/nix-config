{
  legacy,
  unstable,
  inputs,
}: {system, ...}: let
  pkgSet = pkgs:
    import pkgs {
      system = system;
      config.allowUnfree = true;
    };
in {
  nixpkgs.overlays = [
    (_: _: {
      legacy = pkgSet legacy;
      unstable = pkgSet unstable;
    })
    inputs.unison-lang.overlay
  ];
}
