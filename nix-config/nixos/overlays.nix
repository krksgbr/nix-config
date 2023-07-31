{ config, lib, pkgs, inputs, ... }:
let
  myOverlay = self: super:
    {
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
