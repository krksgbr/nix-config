{ config, lib, pkgs, ... }:
{
  programs.zsh.plugins = [
    {
      name = "zaw";
      src = fetchGit {
        url = "https://github.com/zsh-users/zaw.git";
        rev = "c8e6e2a4244491a2b89c2524a2030336be8d7c7f";
      };
    }
  ];
}
