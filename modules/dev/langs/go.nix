{ pkgs, system, myLib, ... }:
let
  go =
    if myLib.isDarwin system then
      {
        homebrew.brews = [ "gopls" "go" ];
      }
    else
      {
        hm.home.packages = with pkgs; [ unstable.gopls go ];
      };
in
go // {
  hm.programs.zsh.initExtra = ''
    export GOPATH=$HOME/go
  '';
}
