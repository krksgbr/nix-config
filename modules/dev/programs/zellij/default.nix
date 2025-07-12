{pkgs, ...}: let
  # fetching from flake is broken
  # zjstatusFlake = builtins.getFlake "github:dj95/zjstatus/8e938da9c303e392f323b38498348f6c33e4de5a";
  # zjstatus = inputs.zjstatus.packages."${system}".default;
  zjstatusWasm = pkgs.fetchurl {
    url = "https://github.com/dj95/zjstatus/releases/download/v0.13.1/zjstatus.wasm";
    # sha256 = lib.fakeSha256;
    sha256 = "sha256-6/fWB803kcM/gZtB4UHIUCJrC1sFz0y+W1Nur0q3gqg";
  };

  zellij-autolock-wasm = pkgs.fetchurl {
    url = "https://github.com/fresh2dev/zellij-autolock/releases/download/0.2.2.rc1/zellij-autolock.wasm";
    # sha256 = lib.fakeSha256;
    sha256 = "sha256-pgOBwIv22eZDoCbKK9kaAMrCLVlF4Fh7FnCdHCocNSU=";
  };
in {
  hm = {
    programs.zellij = {
      enable = true;
      enableZshIntegration = false;
      package = pkgs.unstable.zellij;
    };
    home.file.".config/zellij/plugins/zjstatus.wasm".source = zjstatusWasm;
    home.file.".config/zellij/plugins/zellij-autolock.wasm".source = zellij-autolock-wasm;
  };
}
