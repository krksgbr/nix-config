{ pkgs, hostName, ... }:
{
  environment.systemPackages =
    let
      konfigue-path =
        "$HOME/.config/konfigue#${hostName}";

      rebuild-args =
        "--flake ${konfigue-path}";

      rebuild-command = cmd:
        if pkgs.stdenv.isDarwin then
          if cmd == "switch" then
            "darwin-rebuild ${cmd} ${rebuild-args}"
          else
            "echo 'not available on darwin'"
        else
          "sudo nixos-rebuild ${cmd} ${rebuild-args}";
    in
    [
      (pkgs.writeShellScriptBin "nrs"
        (rebuild-command "switch"))

      (pkgs.writeShellScriptBin "nrt"
        (rebuild-command "test"))

      (pkgs.writeShellScriptBin "nix-env-clean" ''
        nix-env -q | ${pkgs.fzf}/bin/fzf --height 40% -m --reverse | xargs nix-env --uninstall
      '')
    ];
}
