{ config, lib, pkgs, ... }:

{
  programs.zsh.plugins = [
    {
      name = "zsh-history-substring-search";
      src = fetchGit {
        url = "https://github.com/zsh-users/zsh-history-substring-search.git";
        rev = "0f80b8eb3368b46e5e573c1d91ae69eb095db3fb";
      };
    }
  ];
}
