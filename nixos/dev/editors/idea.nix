{ config, lib, pkgs, ... }:
let
  # cli launcher
  idea = pkgs.writeShellScriptBin "idea" ''
    idea-community $1 > /dev/null 2>&1 & disown;
  '';
in
{
  hm = {
    home.packages = with pkgs; [
      idea
      stable.idea.idea-community
    ];
    home.file.".ideavimrc".source = ./ideavimrc;
  };
}
