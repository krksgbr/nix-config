{ config, lib, pkgs, ... }:
{

  environment.systemPackages = [ pkgs.ddcutil pkgs.autorandr ];

  # brightness control with ddcutil for the external monitor
  boot.kernelModules = [ "i2c_dev" ];
  users.groups = {
    i2c = { };
  };
  user.extraGroups = [ "i2c" ];
  services = {
    # ddcutil
    udev.extraRules = ''
      KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    '';
  };


  hm.programs.autorandr =
    let
      monitors = {
        internal = {
          name = "eDP-1";
          fingerprint = "00ffffffffffff0006af362000000000001b0104a51f117802fbd5a65334b6250e505400000001010101010101010101010101010101e65f00a0a0a040503020350035ae100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343051414e30322e30200a00d2";
          config = {
            enable = true;
            crtc = 0;
            mode = "2560x1440";
            position = "0x0";
            primary = true;
            rate = "60.01";
          };
        };
        external = {
          name = "DP-1";
          fingerprint = "00ffffffffffff004a8b560100000000091d0104b52313783e6435a5544f9e27125054bfef80d1c0d1c0d1c0950090408180814081c040d000a0f0703e80302035005ac21000001a000000fc00476f4269676765520a20202020000000ff0064656d6f7365742d310a203020000000fd00183cc8dc3c000a20202020202001a0020323f14f5d5e5f60611f0413051411120102032309070783010000e305c000e200c004740030f2705a80b0588a005ac21000001a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000081";
          config = {
            enable = true;
            crtc = 1;
            mode = "3840x2160";
            position = "2560x0";
            rate = "59.98";
          };
        };
      };

      defaultProfile = {
        fingerprint = {
          "${monitors.internal.name}" = monitors.internal.fingerprint;
          "${monitors.external.name}" = monitors.external.fingerprint;
        };
        config = {
          "${monitors.internal.name}" = monitors.internal.config;
        };
      };
    in
    {
      enable = true;
      profiles = {
        default = defaultProfile // {
          hooks.postswitch = ''
            # kill external polybar
            pkill -f "polybar external"
          '';
        };
        with-external = lib.recursiveUpdate defaultProfile {
          config."${monitors.external.name}" = monitors.external.config;
          hooks.postswitch = ''
            sleep 3
            # set brigthness to max
            ${pkgs.ddcutil}/bin/ddcutil setvcp 10 100 --display 1

            # launch polybar and set wallpaper
            ${pkgs.nitrogen}/bin/nitrogen --restore

            previous=$(ps aux | grep "polybar external" | grep -v grep)
            if [ -z "$previous"  ]; then
               ${pkgs.polybar}/bin/polybar external & disown
            fi
          '';
        };
      };
    };


  # hotplug
  # copied from nixpkgs, because the definition has an issue upstream:
  # https://github.com/NixOS/nixpkgs/issues/98592
  services.udev.packages = [ pkgs.autorandr ];
  systemd.services.autorandr = {
    wantedBy = [ "sleep.target" ];
    description = "Autorandr execution hook";
    after = [ "sleep.target" ];

    serviceConfig = {
      StartLimitBurst = 1;
      KillMode = "process";
      ExecStart = "${pkgs.autorandr}/bin/autorandr --batch --change --default default";
      Type = "oneshot";
      RemainAfterExit = false;
    };
    unitConfig = {
      StartLimitInterval = 5;
    };
  };
}
