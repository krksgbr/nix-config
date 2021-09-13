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
        portable = {
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
        dell = {
          name = "DP-1";
          fingerprint = "00ffffffffffff0010ac23f14c4b31440b1f0104a53c22783a5015a8544fa5270e5054a54b00714f8180a9c0d1c001010101010101014dd000a0f0703e803020350055502100001a000000ff0034344a463543330a2020202020000000fc0044454c4c205032373231510a20000000fd0018560f873c000a20202020202001fd02031eb15661605f5e5d101f222120041312110302010514061516e2006b08e80030f2705a80b0588a0055502100001c565e00a0a0a029503020350055502100001c023a801871382d40582c450055502100001e114400a0800025503020360055502100001c0000000000000000000000000000000000000000000000000065";
          config = {
            enable = true;
            crtc = 1;
            mode = "3840x2160";
            position = "2560x0";
            rate = "60.00";
          };
        };
      };

      defaultProfile = {
        fingerprint = {
          "${monitors.internal.name}" = monitors.internal.fingerprint;
        };
        config = {
          "${monitors.internal.name}" = monitors.internal.config;
        };
      };

      defaultPostSwitch = ''
        # launch polybar and set wallpaper
        ${pkgs.nitrogen}/bin/nitrogen --restore

        previous=$(ps aux | grep "polybar external" | grep -v grep)
        if [ -z "$previous"  ]; then
           ${pkgs.polybar}/bin/polybar external & disown
        fi
      '';
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
        with-portable = lib.recursiveUpdate defaultProfile {
          config."${monitors.portable.name}" = monitors.portable.config;
          fingerprint = {
            "${monitors.portable.name}" = monitors.portable.fingerprint;
          };
          hooks.postswitch = ''
            sleep 3
            # set brigthness to max
            ${pkgs.ddcutil}/bin/ddcutil setvcp 10 100 --display 1
            ${defaultPostSwitch}
          '';
        };
        with-dell = lib.recursiveUpdate defaultProfile {
          config."${monitors.dell.name}" = monitors.dell.config;
          fingerprint = {
            "${monitors.dell.name}" = monitors.dell.fingerprint;
          };
          hooks.postswitch = defaultPostSwitch;
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
