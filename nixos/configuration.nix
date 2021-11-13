{ config, pkgs, lib, options, inputs, ... }:
{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./hardware-configuration.nix
      ./overlays.nix
      ./cachix.nix
      ./system
      ./desktop
      ./dev
      ./etc
    ];

  options = {
    userName = lib.mkOption {
      type = lib.types.str;
    };

    hm = lib.mkOption {
      type = options.home-manager.users.type.functor.wrapped;
      default = { };
      description = ''Alias to home-manager.users."$${userName}"'';
    };

    user = lib.mkOption {
      type = options.users.users.type.functor.wrapped;
      default = { };
      description = ''Alias to users.users."$${userName}"'';
    };
  };

  config =
    let
      userName = config.userName;
    in
    {
      nixpkgs.config.allowUnfree = true;

      users.users."${userName}" = lib.mkAliasDefinitions options.user;

      user = {
        shell = pkgs.zsh;
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "tty" ];
      };

      nix.trustedUsers = [ userName ];

      home-manager = {
        users."${userName}" = lib.mkAliasDefinitions options.hm;
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      hm.home.stateVersion = config.system.stateVersion;


      # This value determines the NixOS release with which your system is to be
      # compatible, in order to avoid breaking some software such as database
      # servers. You should change this only after NixOS release notes say you
      # should.
      system.stateVersion = "21.05"; # Did you read the comment?
    };
}
