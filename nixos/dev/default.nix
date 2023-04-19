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

  hm.services.gpg-agent = {
    enable = true;
  };
}
