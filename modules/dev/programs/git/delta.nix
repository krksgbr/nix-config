{ lib, pkgs, ... }:
{
  hm.home.packages = [ pkgs.gitAndTools.delta ];
  hm.programs.git.extraConfig = {
      core.pager = "delta";
      delta.side-by-side = true;
      delta.line-numbers = true;
      delta.syntax-theme = "Solarized (dark)";
  };
}
