{ home-manager-modules }:
{ config
, pkgs
, lib
, options
, stateVersion
, ...
}:
{
  imports = [
    home-manager-modules
  ];
  options = {
    hm = lib.mkOption {
      type = options.home-manager.users.type.functor.wrapped;
      default = { };
      description = ''Alias to home-manager.users."$${userName}"'';
    };
  };

  config =
    {
      home-manager = {
        users."${config.username}" = lib.mkAliasDefinitions options.hm;
        useGlobalPkgs = true;
        useUserPackages = true;
      };
      hm.home.stateVersion = stateVersion;
    };
}
