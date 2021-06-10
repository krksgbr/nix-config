{ config, lib, pkgs, ... }:

{
  hm.home.packages = with pkgs; [
    docker-compose
  ];

  virtualisation = {
    docker.enable = false;
    libvirtd.enable = true;
  };

  user.extraGroups = [ "docker" ];

}
