{ pkgs, ... }:
{
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [
    "8.8.8.8"
  ];
  networking.hostName = "krks";
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.enable = true;
    publish.addresses = true;
    publish.workstation = true;
  };
}
