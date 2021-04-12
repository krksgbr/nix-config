{ lib, pkgs, ... }:
{
  home.packages = [ pkgs.gitAndTools.delta ];
  programs.git.extraConfig = {
      core.pager = "delta";
      delta.side-by-side = true;
      delta.line-numbers = true;
      delta.syntax-theme = "Solarized (dark)";
  };
}
