{ pkgs ? (import <nixpkgs> {}) }:
let
  inherit (pkgs) lib;
  fonts = {
     iosevka = ./iosevka/iosevka-custom/ttf;
     input = ./input/Input_Fonts/Input;
     allTheIcons = ./all-the-icons;
     # iosevka term patched with fira-code ligatures to support kitty
     # https://github.com/be5invis/Iosevka/issues/248#issuecomment-414131620
     iosevkaTermCustom = ./iosevkaTermCustom;
  };

  cmds = lib.concatStringsSep "\n" (
           lib.mapAttrsToList(key: value: "cp \$${key}/* $out") fonts
  );
  
in
  pkgs.stdenv.mkDerivation (fonts // {
    name = "local-fonts";
    phases = ["installPhase"];
    installPhase = ''
      mkdir $out
      ${cmds}
'';
})
