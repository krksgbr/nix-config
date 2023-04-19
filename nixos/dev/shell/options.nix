{ config, lib, pkgs, ... }:
{
  options.my = {
    shell.aliases = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
    };
    shell.sessionVariables = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
    };
  };
}
