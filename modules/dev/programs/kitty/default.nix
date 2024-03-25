{ config, lib, pkgs, myLib, system, ... }:
let
  darwinKittyConf = ''
    placement_strategy top-left

    # The window margin (in pts) (blank area outside the border)
    window_margin_width 10

    # Hide the kitty window's title bar on macOS.
    macos_hide_titlebar true

    # Fonts
    font_size        19.0

    font_family      Iosevka Term Regular
    italic_font      Iosevka Term Italic 
    bold_font        Iosevka Term Bold 
    bold_italic_font Iosevka Term Bold Italic
      
    # Nerd Font symbols
    symbol_map U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6AA,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF,U+F0001-U+F1AF0 Symbols Nerd Font Mono Regular
  '';

  kittyConf = ''
    ${builtins.readFile ./kitty.conf}
  '';
  isDarwin = myLib.isDarwin system;
in
{
  hm.programs.kitty = {
    enable = true;
    extraConfig = ''
      ${kittyConf}
      ${if isDarwin then darwinKittyConf else ""}
    '';
  };
  fonts = lib.mkIf isDarwin {
    fontDir.enable = true;
    fonts = [
      (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
  };
}
