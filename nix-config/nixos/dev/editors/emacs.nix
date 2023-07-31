{ config, lib, pkgs, ... }:


let
  # emacs wrapper
  e = pkgs.writeShellScriptBin "e" ''
    emacs $1 > /dev/null 2>&1 & disown;
  '';
in
{
  hm = {
    home.packages = with pkgs; [
      e
      fd
      shellcheck
    ];
    programs.emacs = {
      enable = true;
      #package = pkgs.emacsGcc;
    };
    home.sessionPath = [
      "$HOME/.config/emacs/bin"
    ];
    services.emacs.enable = true;
  };

}
