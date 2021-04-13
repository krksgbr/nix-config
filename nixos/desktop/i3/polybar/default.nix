{ config, lib, pkgs, ... }:
{
  hm.services.polybar = {
    enable = true;
    config = ./config;
    script = "polybar default &";
  };

  nixpkgs.overlays = [
    (self: super: {
      polybar = super.polybar.override {
        i3Support = true;
        alsaSupport = true;
        pulseSupport = true;
        nlSupport = true;
      };
    })
  ];
}
