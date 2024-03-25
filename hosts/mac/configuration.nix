{ pkgs, inputs, config, system, ... }: {

  username = "gaborkerekes";
  imports = [
    ./brew.nix
    ./pam.nix
    ./programs/deluge
    ./programs/orbstack
    ###################
    ../../modules/dev
  ];

  custom.security.pam =
    {
      enableSudoTouchIdAuth = true;
      enablePamReattach = true;
    };

  # Explicitly set home directory for user
  # https://github.com/nix-community/home-manager/issues/4026
  user.home = "/Users/${config.username}/";

  hm.programs.zsh.initExtra = ''
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '';

  environment.systemPackages = with pkgs; [
    vim
    unstable.deluge
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

  # Set Git commit hash for darwin-version.
  system.configurationRevision = with inputs; self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
