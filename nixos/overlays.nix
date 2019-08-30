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
}
