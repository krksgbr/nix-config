# create an ssh tunnel to a remote deluge daemon and launch a local deluge gui

function killssh {
    kill $SSH_PID
}

trap killssh SIGINT SIGTERM EXIT

ssh -NL 127.0.0.2:58846:localhost:58846 198.100.149.149 &
SSH_PID="$!"

nix run unstable.deluge-2_x -c "deluge"
