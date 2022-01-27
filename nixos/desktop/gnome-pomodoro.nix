{ config, lib, pkgs, ... }:
let
  src = fetchGit {
    url = "https://github.com/kantord/i3-gnome-pomodoro.git";
    rev = "963960490e31d8a89cee0dca8e615babb84553a9";
  };
  i3-gnome-pomodoro = pkgs.stdenv.mkDerivation
    {
      name = "i3-gnome-pomodoro";
      buildInputs = [
        (pkgs.legacy.python3.withPackages (ps: [
          ps.pygobject3
          ps.pydbus
          ps.click
          ps.i3ipc
        ]))
      ];
      unpackPhase = "true";
      installPhase = ''
        mkdir -p $out/bin
        cp ${src}/pomodoro-client.py $out/bin/i3-gnome-pomodoro
        chmod +x $out/bin/i3-gnome-pomodoro
      '';
    };
in
{
  hm.home.packages = [
    pkgs.gnome.pomodoro
    i3-gnome-pomodoro
  ];
}
