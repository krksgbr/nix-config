{
  modulesPath,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./orbstack.nix
    # Additional NixOS-specific imports
  ];

  username = "flakey";
  user.isNormalUser = true;
  user.group = "flakey";
  users.groups.flakey = {};
  user.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    lsof
    wget
  ];

  hm.programs.zellij.enableZshIntegration = false;
  hm.programs.zsh.initContent = ''
    export XDG_RUNTIME_DIR="$HOME/.local/share/${config.username}/xdg_runtime_dir";
  '';

  # FIX THIS
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.15.3"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  # As this is intended as a stadalone image, undo some of the minimal profile stuff
  documentation.enable = true;
  documentation.nixos.enable = true;
  environment.noXlibs = false;
}
