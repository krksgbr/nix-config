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
    settings.PermitRootLogin = "prohibit-password";
  };

  hm.services.gpg-agent = {
    enable = true;
  };
}
