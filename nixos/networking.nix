{ pkgs, ... }:
{
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [
    "8.8.8.8"
  ];
}
