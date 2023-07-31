{ config, lib, pkgs, ... }:

{
  # Enable touchpad support.
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      accelSpeed = "1.0";
    };
  };
}
