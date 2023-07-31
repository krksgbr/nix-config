{ config, lib, pkgs, ... }:

{
  programs.zsh.plugins = [
    {
      name = "zsh-completions";
      src = fetchGit {
        url = "https://github.com/zsh-users/zsh-completions.git";
        rev = "b512d57b6d0d2b85368a8068ec1a13288a93d267";
      };
    }
  ];
}
