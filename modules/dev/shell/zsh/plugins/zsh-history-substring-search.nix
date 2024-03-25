{ config, lib, pkgs, ... }:

{
  programs.zsh.initExtra = ''
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=yellow,fg=black,bold"
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=red,fg=black,bold"
  '';
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
