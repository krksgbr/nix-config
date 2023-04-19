{ config, lib, pkgs, ... }:
{
  hm.programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty.conf;
  };
}
