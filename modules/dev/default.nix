{ pkgs, ... }:
{
  imports = [
    ./shell
    ./programs
    ./langs
  ];

  hm.home.packages = with pkgs; [
    gcc
    gnumake
    pkg-config
  ];
}
