{ config, lib, pkgs, ... }:
{
  hm.services.polybar = {
    enable = true;
    config = ./config;
    script = "polybar default &";
  };

  # restart polybar because hm starts it before i3, so modules aren't showing
  # https://github.com/nix-community/home-manager/issues/3722
  hm.xsession.initExtra =
    ''
      bash -c 'sleep 1 && systemctl --user restart polybar' &
    '';

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
