{ pkgs, ... }:
let
  txt = builtins.readFile ./mount-android.sh;
  script = pkgs.writeShellScriptBin "android" ''
  ${txt}
'';
in
{
  environment.systemPackages = with pkgs; [
      jmtpfs # for android file transfer
      script
  ];
}
