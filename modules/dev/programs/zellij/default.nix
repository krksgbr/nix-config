{ system, lib, pkgs, ... }:
let
  # fetching from flake is broken
  # zjstatusFlake = builtins.getFlake "github:dj95/zjstatus/8e938da9c303e392f323b38498348f6c33e4de5a";
  # zjstatus = zjstatusFlake.packages."${system}".default;
  zjstatusWasmUrl = "https://github.com/dj95/zjstatus/releases/download/v0.13.1/zjstatus.wasm";
  zjstatusWasm = pkgs.fetchurl {
    url = zjstatusWasmUrl;
		# sha256 = lib.fakeSha256;
    sha256 = "sha256-6/fWB803kcM/gZtB4UHIUCJrC1sFz0y+W1Nur0q3gqg";
  };
in
{
  hm = {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
    };
    home.file.".config/zellij/plugins/zjstatus.wasm".source = zjstatusWasm;
  };
}
