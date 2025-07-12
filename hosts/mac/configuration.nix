{
  pkgs,
  inputs,
  config,
  ...
}: {
  username = "gaborkerekes";
  imports = [
    ./brew.nix
    ./programs/deluge
    ./programs/orbstack
    ./programs/aerospace
    ###################
    ../../modules/dev
  ];

  ######################################################### Security #########################################################

  ## Authenticate sudo with Touch ID
  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };

  ######################################################### User #########################################################

  # Explicitly set home directory for user
  # https://github.com/nix-community/home-manager/issues/6036
  # https://github.com/nix-community/home-manager/issues/4026
  user.home = "/Users/${config.username}/";
  nix.settings.trusted-users = [
    "root"
    config.username
  ];

  system.primaryUser = config.username;

  # The gid setting is a workaround for the error below. It can be removed if nix is ever re-installed.
  #
  # error: Build user group has mismatching GID, aborting activation
  # The default Nix build user group ID was changed from 30000 to 350.
  # You are currently managing Nix build users with nix-darwin, but your
  # nixbld group has GID 350, whereas we expected 30000.
  #
  # Possible causes include setting up a new Nix installation with an
  # existing nix-darwin configuration, setting up a new nix-darwin
  # installation with an existing Nix installation, or manually increasing
  # your `system.stateVersion` setting.
  #
  # You can set the configured group ID to match the actual value:
  #
  #     ids.gids.nixbld = 350;
  #
  # We do not recommend trying to change the group ID with macOS user
  # management tools without a complete uninstallation and reinstallation
  # of Nix.
  ids.gids.nixbld = 350;

  ######################################################### Environment #########################################################

  hm.programs.zsh.initContent = ''
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '';

  my.shell.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  environment.systemPackages = with pkgs; [
    vim
    unstable.deluge
    openssh
    age
    age-plugin-se
    age-plugin-yubikey
  ];

  # environment.etc."hosts" = {
  #   copy = true;
  #   text = ''
  #     ##
  #     # Host Database
  #     #
  #     # localhost is used to configure the loopback interface
  #     # when the system is booting.  Do not change this entry.
  #     ##
  #     127.0.0.1   localhost
  #     255.255.255.255 broadcasthost
  #     ::1             localhost
  #     192.168.64.5    nixos
  #   '';
  # };

  ######################################################### System #########################################################

  # Set Git commit hash for darwin-version.
  system.configurationRevision = with inputs; self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
