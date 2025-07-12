{home-manager-modules}: {
  config,
  lib,
  options,
  stateVersion,
  ...
}: {
  imports = [
    home-manager-modules
  ];
  options = {
    hm = lib.mkOption {
      type = options.home-manager.users.type.nestedTypes.elemType;
      default = {};
      description = ''Alias to home-manager.users."$${userName}"'';
    };
  };

  config = {
    home-manager = {
      users."${config.username}" = lib.mkAliasDefinitions options.hm;
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bup";
    };
    hm = {
      manual.json.enable = true;
      manual.html.enable = true;
      manual.manpages.enable = true;
      home.stateVersion = stateVersion;
    };
  };
}
