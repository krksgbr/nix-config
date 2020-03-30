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

  lorri = import (builtins.fetchTarball {
    url = "https://github.com/target/lorri/archive/88c680c9abf0f04f2e294436d20073ccf26f0781.tar.gz";
    sha256 = "1415mhdr0pwvshs04clfz1ys76r5qf9jz8jchm63l6llaj6m7mrv";
  }) {};

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
