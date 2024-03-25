{ config, lib, options, ... }:
{
  options = {
    username = lib.mkOption {
      type = lib.types.str;
    };
    user = lib.mkOption {
      type = options.users.users.type.functor.wrapped;
      default = { };
      description = ''Alias to users.users."$${userName}"'';
    };
  };

  config =
    {
      users.users."${config.username}" = lib.mkAliasDefinitions options.user;
    };
}
