{ config, lib, pkgs, ... }:
let
  fzf = "${pkgs.fzf}/bin/fzf-tmux";

  # recent branches
  rc = pkgs.writeShellScriptBin "git-rc" ''
    set -euo pipefail
    branches=$(git reflog | egrep -io "moving from ([^[:space:]]+)" | awk '{ print $3 }' | awk ' !x[$0]++' | egrep -v '^[a-f0-9]{40}$' | head -n8)
    branch=$(echo "$branches" | ${fzf} +m)
    git checkout $branch
  '';

  # checkout with fzf
  co = pkgs.writeShellScriptBin "git-co" ''
    set -euo pipefail
    branches=$(git --no-pager branch --sort=-committerdate -vv) &&
    branch=$(echo "$branches" | ${fzf} +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
  '';
in
{
  home.packages = [ rc co ];
}
