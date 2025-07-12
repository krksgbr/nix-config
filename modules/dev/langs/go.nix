{
  pkgs,
  lib,
  ...
}:
lib.mkMerge [
  # Darwin-specific configuration
  (lib.mkIf (pkgs.stdenv.isDarwin) {
    homebrew.brews = [
      "gopls"
      "go"
    ];
  })

  # NixOS-specific configuration
  (lib.mkIf (pkgs.stdenv.isLinux) {
    hm.home.packages = with pkgs; [
      unstable.gopls
      go
    ];
  })

  # Common configuration for both platforms
  {
    hm.programs.zsh.initContent = ''
      export GOPATH=$HOME/go
    '';
  }
]
