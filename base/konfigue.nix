{
  pkgs,
  hostName,
  ...
}: {
  environment.systemPackages = let
    konfigue-path = "$HOME/.config/konfigue";
    rebuild-args = "--flake ${konfigue-path}#${hostName}";

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
      then "darwin-rebuild switch --flake ${konfigue-path}#${hostName}"
      else ''echo "${usage}"'';
  in [
    (
      pkgs.writeShellScriptBin "konfigue"
      ''
        CMD=$1
        case "$CMD" in
          "switch")
            ${rebuild-command "switch"}
            ;;
          "test")
            ${rebuild-command "test"}
            ;;
          "edit")
            cd -P ${konfigue-path} && nvim .
            ;;
          *)
            echo "Usage: ${usage}"
            exit 1
            ;;
        esac
      ''
    )
  ];
}
