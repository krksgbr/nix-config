{ config, lib, pkgs, ... }:

{
  imports = [
    ./shell
    ./editors
    ./langs
    ./term
    ./virtualisation.nix
  ];

  services.openssh = {
    enable = true;
    permitRootLogin = "prohibit-password";
  };

  hm.services.gpg-agent = {
    enable = true;
  };
}
