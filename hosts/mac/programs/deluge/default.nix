{ pkgs, ... }:
let
  withSSHTunnel = delugeCmd: pkgs.writeScriptBin "torrents" ''
    # create an ssh tunnel to a remote deluge daemon and launch a local deluge gui

    function killssh {
      kill $SSH_PID
      echo "killed shh tunnel $SSH_PID"
    }

    trap killssh SIGINT SIGTERM EXIT

    ssh -NL 127.0.0.1:58846:localhost:58846 gabor@198.100.149.149 &
    SSH_PID="$!"
    
    ${delugeCmd}
  '';
in
{
  homebrew.taps = [ "amar1729/deluge-meta" ];
  homebrew.brews = [ "deluge-meta" ];
  hm.home.packages = [ (withSSHTunnel "/opt/homebrew/bin/deluge") ];
}
