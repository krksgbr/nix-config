{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    extraConfig = "
       [General]
       Enable=Source,Sink,Media,Socket
     ";
  };

  hardware.pulseaudio = {
    package = pkgs.pulseaudioFull;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    extraConfig = ''
      load-module module-bluetooth-policy
      load-module module-bluetooth-discover
      ## module fails to load with
      ##   module-bluez5-device.c: Failed to get device path from module arguments
      ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
      # load-module module-bluez5-device
      # load-module module-bluez5-discover
      load-module module-switch-on-connect
    '';
  };
  services.blueman.enable = true;
}
