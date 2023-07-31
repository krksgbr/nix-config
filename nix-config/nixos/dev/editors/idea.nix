{ config, lib, pkgs, ... }:
let
  # cli launcher
  cliLauncher = pkgs.writeShellScriptBin "idea" ''
    com.jetbrains.IntelliJ-IDEA-Community $1 > /dev/null 2>&1 & disown;
  '';
in
{
  hm = {
    home.packages = with pkgs; [
      cliLauncher
      # using idea from flatpak
      # jetbrains.idea-community
    ];
    home.file.".ideavimrc".source = ./ideavimrc;
  };
}
