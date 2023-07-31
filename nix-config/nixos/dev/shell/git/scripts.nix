{ config, lib, pkgs, ... }:
let
  fzf = "${pkgs.fzf}/bin/fzf --height 20%";

  # recent branches
  rb = pkgs.writeShellScriptBin "git-rb" ''
    set -euo pipefail
    branches=$(git reflog | egrep -io "moving from ([^[:space:]]+)" | awk '{ print $3 }' | awk ' !x[$0]++' | egrep -v '^[a-f0-9]{40}$' | head -n20)
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

  can-merge = pkgs.writeShellScriptBin "git-can-merge" ''
    branches=$(git --no-pager branch --sort=-committerdate -vv)
    branch=$(echo "$branches" | ${fzf} +m)
    branch=$(echo "$branch" | awk '{print $1}' | sed "s/.* //")

    git merge "$branch" --no-ff --no-commit > /dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo "Nope"
    else
        echo "Yes"
    fi

    git merge --abort > /dev/null 2>&1
  '';

  pr = pkgs.writeShellScriptBin "git-pr" ''
    echo "What should I name this branch? (Default: $1)"
    read branch_name
    branch_name=''${branch_name:-$1}
    echo "Fetching PR $1 to pr/$branch_name"
    git fetch -fu upstream refs/pull/$1/head:pr/$branch_name && git checkout pr/$branch_name;
  '';
in
{
  hm.home.packages = [ rb co prune-local can-merge pr ];
}
