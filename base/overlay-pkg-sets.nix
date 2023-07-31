{ legacy, unstable }:
{ system, ... }:
let
  pkgSet = pkgs:
    import pkgs {
      system = system;
      config.allowUnfree = true;
    };
in
{
  nixpkgs.overlays =
    [
      (_: _:
        {
          legacy = pkgSet legacy;
          unstable = pkgSet unstable;
        })
    ];
}
