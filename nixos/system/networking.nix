{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [
    "8.8.8.8"
  ];

  networking.interfaces.wlp0s20f3.useDHCP = false;
  networking.interfaces.wlp0s20f3.ipv4.addresses = [{
    address = "192.168.1.199";
    prefixLength = 24;
  }];

  networking.defaultGateway = "192.168.1.1";
  networking.firewall.allowedTCPPorts = [
    1234
    5000
    8080
    8888
    9000
    22
  ];
  hm.home.packages = [
    pkgs.networkmanagerapplet
  ];
}
