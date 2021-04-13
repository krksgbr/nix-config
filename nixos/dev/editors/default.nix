{ config, lib, pkgs, ... }:
let
  # emacs wrapper
  e = pkgs.writeShellScriptBin "e" ''
    emacs $1 > /dev/null 2>&1 & disown;
  '';
in
{
  imports = [
    ./idea.nix
    ./vim.nix
  ];

  fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];
  hm = {
    home.packages = [ e ];
    programs.emacs = {
      enable = true;
    };
    home.sessionPath = [
      "$HOME/.emacs.d/bin"
    ];
  };
}
