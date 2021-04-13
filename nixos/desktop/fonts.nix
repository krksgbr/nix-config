{ config, lib, pkgs, ... }:
let
  iosevka =
    let
      version = "5.2.1";
    in
    pkgs.fetchzip {
      name = "iosevka-${version}";
      url = "https://github.com/be5invis/Iosevka/releases/download/v${version}/ttc-iosevka-${version}.zip";
      postFetch = ''
        mkdir -p $out/share/fonts
        unzip -j $downloadedFile \*.ttc -d $out/share/fonts/truetype
      '';
      sha256 = "avzrEvRW87ZShSnU9OGu+Uywq3gXp91l5V9bK+WOoXU=";
    };
in
{
  fonts.enableDefaultFonts = false;
  fonts.fonts = [
    pkgs.liberation_ttf_v2
    pkgs.joypixels
    pkgs.ibm-plex
    iosevka
  ];

  nixpkgs.config.joypixels.acceptLicense = true;
  fonts.fontconfig.defaultFonts = {
    emoji = [ "JoyPixels" ];
    sansSerif = [ "IBM Plex Sans" ];
    serif = [ "IBM Plex Serif" ];
    monospace = [ "Iosevka" ];
  };
}
