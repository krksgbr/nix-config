{ config, lib, pkgs, ... }:

{
  imports = [
    ./shell
    ./editors
    ./langs
    ./term
    ./virtualisation.nix
  ];

  services.openssh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };
}
