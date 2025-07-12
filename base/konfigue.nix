{
  pkgs,
  hostName,
  ...
}: {
  environment.systemPackages = let
    konfigue-path = "$HOME/.config/konfigue";
    usage =
      if pkgs.stdenv.isLinux
      then "konfigue {switch|test|edit}"
      else "konfigue {switch|edit}";

    rebuild-command = cmd:
      if pkgs.stdenv.isLinux
      then
        ## Orbstack specific setup:
        ## `konfigue-path` is a symbolic link inside the Orbstack machine.
        ## cd -P changes to the actual directory.
        ## For other linux hosts this won't make sense.
        "cd -P ${konfigue-path} && sudo nixos-rebuild ${cmd} --flake .#${hostName} && cd -"
      else if cmd == "switch"
      then "sudo darwin-rebuild switch --flake ${konfigue-path}"
      else ''echo "${usage}"'';
  in [
    (
      pkgs.writeShellScriptBin "k"
      ''
        CMD=$1

        edit() {
          cd -P ${konfigue-path} && nvim .
        }

        case "$CMD" in
          "switch")
            ${rebuild-command "switch"}
            ;;
          "test")
            ${rebuild-command "test"}
            ;;
          "edit")
            edit
            ;;
          *)
            if [ -z "$CMD" ]; then
              edit
            else
              echo "Usage: ${usage}"
              exit 1
            fi
            ;;
        esac
      ''
    )
  ];
}
