{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./shell
    ./programs
    ./langs
  ];

  hm.home.packages = with pkgs; [
    go
    gcc
    gnumake
    pkg-config
    sad
    fd
  ];

  hm.services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    extraConfig = lib.mkIf (pkgs.stdenv.isDarwin) ''
      pinentry-program /opt/homebrew/bin/pinentry-mac
    '';
  };
}
