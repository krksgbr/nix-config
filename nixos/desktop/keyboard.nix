{ config, lib, pkgs, ... }:

{
  services.xserver = {
    layout = "us";
    xkbOptions = "eurosign:e, ctrl:nocaps";
  };
  # This will apply the X keymap to the console keymap,
  # which affects virtual consoles such as tty
  # https://unix.stackexchange.com/questions/377600/in-nixos-how-to-remap-caps-lock-to-control
  console.useXkbConfig = true;
}
