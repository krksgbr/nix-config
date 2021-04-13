{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    plugins = [
      {
        name = "enhancd";
        file = "init.sh";
        src = fetchGit {
          url = "https://github.com/b4b4r07/enhancd.git";
          rev = "2ccdacae00750766c13e0b1319c8881dc626d3ec";
        };
      }
    ];
    sessionVariables = {
      ENHANCD_HYPHEN_ARG = "=";
      ENHANCD_DOT_ARG = ".";
    };
  };
}
