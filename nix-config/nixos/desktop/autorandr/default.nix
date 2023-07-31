{ config, lib, pkgs, ... }:
{
  hm.home.file.".config/autorandr" = {
    source = ./profiles;
    recursive = true;
  };

  hm.programs.autorandr.enable = true;
  hm.xsession = {
    enable = true;
    initExtra = ''
      # autorandr -c
      # the command above doesn't seem to override the automatic screen resolution
      # coming from the spice daemon
      autorandr --load macbook
    '';
  };

  services.xserver.exportConfiguration = true; # useful for debugging
  services.xserver.extraConfig = ''
    # Mode matching macbook pro 16" internal dimensions
    Section "Monitor"
        Identifier "Virtual-1"
        Modeline "3456x2160_60.00"  642.00  3456 3744 4120 4784  2160 2163 2169 2237 -hsync +vsync
    EndSection
  '';


  # hotplug
  # copied from nixpkgs, because the definition has an issue upstream:
  # https://github.com/NixOS/nixpkgs/issues/98592
  # services.udev.packages = [ pkgs.autorandr ];
  # systemd.services.autorandr = {
  #   wantedBy = [ "sleep.target" ];
  #   description = "Autorandr execution hook";
  #   after = [ "sleep.target" ];

  #   serviceConfig = {
  #     StartLimitBurst = 1;
  #     KillMode = "process";
  #     ExecStart = "${pkgs.autorandr}/bin/autorandr --batch --change --default macbook";
  #     Type = "oneshot";
  #     RemainAfterExit = false;
  #   };
  #   unitConfig = {
  #     StartLimitInterval = 5;
  #   };
  # };
}
