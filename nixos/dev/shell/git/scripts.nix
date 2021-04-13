{ config, lib, pkgs, ... }:
let
  fzf = "${pkgs.fzf}/bin/fzf --height 20%";

  # recent branches
  rb = pkgs.writeShellScriptBin "git-rb" ''
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

  # for cleaning up old local branches
  prune-local = pkgs.writeShellScriptBin "git-prune-local" ''
    git branch -v  | awk '{ if ($1 != "*") {print} }' | fzf --height 40% -m --reverse | awk '{print $1}' | xargs git branch -D
  '';
in
{
  hm.home.packages = [ rb co prune-local];
}
