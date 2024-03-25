{ pkgs, myLib, system, ... }:
let
  gopls =
    if myLib.isDarwin system then
      {
        homebrew.brews = [ "gopls" ];
      }
    else
      {
        hm.home.packages = [ pkgs.unstable.gopls ];
      };
in
gopls // {
  hm.home.packages = [
    pkgs.go
  ];
  hm.programs.zsh.initExtra = ''
    export GOPATH=$HOME/go
  '';
}
