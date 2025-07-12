{
  config,
  pkgs,
  ...
}: {
  # Enable Avahi daemon for mDNS
  services.avahi = {
    enable = true;
    nssmdns = true; # Enable mDNS resolver
    publish = {
      enable = true; # Enable publishing of local services
      userServices = true; # Allow users to publish services
    };
    # cacheEntriesMax = 0;
    # ipv6 = false;
    # ipv4 = true;
  };

  # Adjust the firewall to allow mDNS
  networking.firewall.allowedUDPPorts = [5353]; # mDNS uses UDP port 5353
}
