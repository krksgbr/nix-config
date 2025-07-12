{...}: {
  hm.programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
  my.shell.aliases.tree = "eza --tree";
}
