{ config, lib, pkgs, ... }:

{
  hm.home.packages = with pkgs; [
    docker-compose
  ];

  virtualisation = {
    docker.enable = false;
    libvirtd.enable = true;
    #virtualbox.host.enable = true;
    #virtualbox.host.package = pkgs.unstable.virtualbox;
  };

  security.polkit.enable = true;

  # create docker group so that it always exists
  # this makes it easier to enable/disable docker
  # because a re-login is required for group changes to take effect
  users.groups.docker = {};
  user.extraGroups = [ "docker" ];

}
