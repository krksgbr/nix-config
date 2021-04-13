{ config, lib, pkgs, ... }:

{
  hm.home.packages = with pkgs; [
    docker-compose
  ];

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  user.extraGroups = [ "docker" ];

}
