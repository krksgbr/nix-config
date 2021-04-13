{ config, lib, pkgs, ... }:
let
  src = fetchGit {
    url = "https://github.com/sindresorhus/pure.git";
    ref = "main";
    rev = "42d3b83647e6bc9ce9767f6f805ee054fd9710cf";
  };
in
{
  home.file = {
    ".zsh/functions/prompt_pure_setup".source = "${src}/pure.zsh";
    ".zsh/functions/async".source = "${src}/async.zsh";
  };

  programs.zsh.plugins = [
    {
      name = "pure";
      inherit src;
    }
  ];
}
