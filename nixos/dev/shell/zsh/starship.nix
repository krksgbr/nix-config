{ config, lib, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory$git_branch$git_commit$git_status$git_state$nix_shell\n$character";
      git_branch = {
        format = "[| $branch]($style)";
        style = "bright-green";
      };
      git_status = {
        format = "$ahead_behind$modified$untracked$staged";
        ahead = "[ ⇡](green)";
        behind = "[ ⇣](green)";
        diverged = "[ ⇕](yellow)";
        modified = "[*](bright-green)";
        untracked = "[*](red)";
        staged = "[+](green)";
      };
      git_commit = {
        style = "yellow";
        format = " [\\($hash\\)]($style) [\\($tag\\)]($style)";
      };
      git_state = {
        format = " \([$state( $progress_current/$progress_total)]($style)\)";
      };
      nix_shell = {
        format = " [|](bright-green) [❄]($style)";
        style = "bright-green";
      };
    };
  };
}
