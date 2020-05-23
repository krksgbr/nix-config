{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jmtpfs # for android file transfer
    (pkgs.mkScript "android" ./mount-android.sh)
  ];
}
