{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> {
    config = config;
  };
in
{
  home.packages = [ unstable.gitAndTools.delta ];
  programs.git.extraConfig = {
      core.pager = "delta";
      delta.side-by-side = true;
      delta.line-numbers = true;
      delta.syntax-theme = "Solarized (dark)";
  };
}
