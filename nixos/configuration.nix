# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, options, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      inputs.home-manager.nixosModules.home-manager
      ./hardware-configuration.nix
      ./overlays.nix
      ./cachix.nix
      ./system
      ./desktop
      ./dev
      ./music-tools
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

      hardware.video.hidpi.enable = true;

      fileSystems."/home/gabor/wormhole" =
        {
          device = "share";
          fsType = "9p";
          options = [ "trans=virtio" "version=9p2000.L" "rw" "_netdev" "nofail" ];
        };


      nixpkgs.config.allowUnfree = true;
      #nixpkgs.config.allowUnsupportedSystem = true;

      nixpkgs.config.permittedInsecurePackages = [
        # dependency of something
        # would be good to figure out where it comes from
        "electron-13.6.9"
      ];


      users.users."${userName}" = lib.mkAliasDefinitions options.user;

      user = {
        shell = pkgs.zsh;
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "tty" ];
        hashedPassword = "$6$v7qRdhtrUnB.ElX.$KZzCZBgKykz6BOZaPJ05H/rdveUxGgyqu9JsgaBWjL8tkd/gO.4L.YltWALsePOk9ogz8ejealehL5yPZ4eLj/";
      };

      users.users.root = {
        hashedPassword = "$6$v7qRdhtrUnB.ElX.$KZzCZBgKykz6BOZaPJ05H/rdveUxGgyqu9JsgaBWjL8tkd/gO.4L.YltWALsePOk9ogz8ejealehL5yPZ4eLj/";
      };

      #nix.settings.trustedUsers = [ userName ];
      nix.extraOptions = ''
        experimental-features = nix-command flakes
      '';

      home-manager = {
        users."${userName}" = lib.mkAliasDefinitions options.hm;
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      hm.home.stateVersion = config.system.stateVersion;
      #hm.home.file.".config/i3/config".source = ./desktop/i3/config;

      users.mutableUsers = true;

      # qemu / utm clipboard sharing
      services.spice-vdagentd.enable = true;

      # also start spice-vdagent (companion to vdagentd) as it doesn't seem to be started automatically when enabling the service
      hm.xsession.initExtra = ''
        spice-vdagent
      '';


      services.qemuGuest.enable = true;

      # Use the systemd-boot EFI boot loader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;


      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "22.11"; # Did you read the comment?
    };
}
