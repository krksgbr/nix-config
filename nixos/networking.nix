{ pkgs, config, ... }:
{
  networking = {
    hostName = "nixos";
    extraHosts = "127.0.0.1 nixos";
    wireless = {
      enable = true;
      # Issue 1: Add a dummy network to make sure wpa_supplicant.conf
      # is created (see https://github.com/NixOS/nixpkgs/issues/23196)
      networks."12345-i-do-not-exist" = {
        extraConfig = ''
          disabled=1
        '';
      };
    };
    # Legacy networkmanager config
    networkmanager = {
      enable = false;
      # Cloudflare DNS; advertised as using good privacy practices (https://1.1.1.1/)
      # insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
      packages = [ pkgs.networkmanagerapplet ];
    };
  };


  services.connman = {
    enable = true;
    networkInterfaceBlacklist = [
      "vboxnet"
      "zt"
      "vmnet"
      "vboxnet"
      "virbr"
      "ifb"
      "docker"
      "veth"
      "eth"
      "wlan"
    ];
    extraConfig = ''
      [General]
      AllowHostnameUpdates=false
      AllowDomainnameUpdates=false
      EnableOnlineCheck=true

      # Ethernet will generally be used for internet, use as default route
      PreferredTechnologies=ethernet,wifi

      # Allow simultaneous connection to ethernet and wifi
      SingleConnectedTechnology=false
    '';
  };
}
