{ config, lib, pkgs, ... }:
{
  options.my = {
    shell.aliases = lib.mkOption {
      type = lib.types.attrs;
    };
    shell.sessionVariables = lib.mkOption {
      type = lib.types.attrs;
    };
  };
}
