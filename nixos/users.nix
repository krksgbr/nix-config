{ pkgs, ... }:
{
  users.users.gabor = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "docker" ];
  };

  nix.trustedUsers = [ "gabor" ];
}
