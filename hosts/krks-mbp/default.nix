{ pkgs, inputs, config, ... }: {
  username = "gaborkerekes";

  imports = [
    ./brew.nix
    ../../modules/shell
    ../../modules/programs
    ../../modules/programs/kitty
  ];

  # Explicitly set home directory for user
  # https://github.com/nix-community/home-manager/issues/4026
  user.home = "/Users/${config.username}/";

  hm.programs.zsh.initExtra = ''
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '';

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.vim
    ];

  environment.etc."hosts" = {
    copy = true;
    text = ''
      ##
      # Host Database
      #
      # localhost is used to configure the loopback interface
      # when the system is booting.  Do not change this entry.
      ##
      127.0.0.1   localhost
      255.255.255.255 broadcasthost
      ::1             localhost
      192.168.64.5    nixos
    '';
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = with inputs; self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
