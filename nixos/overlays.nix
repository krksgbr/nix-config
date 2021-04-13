{ config, lib, pkgs, inputs, ... }:
let
  myOverlay = self: super:
    {
      stable = import inputs.nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      mkScript = (scriptName: file:
        let
          txt = builtins.readFile file;
        in
        self.writeShellScriptBin scriptName ''
          ${txt}
        ''
      );
    };
in
{
  nixpkgs.overlays = [ myOverlay ];
}
