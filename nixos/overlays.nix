config: self: super:
let
  unstable = import <unstable> {
    config = config.nixpkgs.config;
  };
in
{
  htop-vim = super.htop.overrideAttrs ( oldAttrs: {
      name = "htop-vim";
      patches = (oldAttrs.patches or []) ++ [./htop-vim.patch];
  });

  polybar = unstable.polybar.override {
    i3Support = true;
    alsaSupport = true;
    pulseSupport = true;
    nlSupport = true;
  };

  networkmanager_dmenu = super.networkmanager_dmenu.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [./networkmanager-dmenu.patch];
  });

  inherit unstable;

  haskell =
    let
      ormolu = import (builtins.fetchGit {
        name = "ormolu";
        url = "https://github.com/tweag/ormolu.git";
        rev = "55d8b7f8c482655ea575425e55352e650f304ea0";
      }) { pkgs = self; };
    in
      super.haskell // {
        packages = super.haskell.packages // {
          "${ormolu.ormoluCompiler}" = super.haskell.packages.${ormolu.ormoluCompiler}.override {
            overrides = ormolu.ormoluOverlay;
          };
        };
      };
}
