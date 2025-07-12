{config, ...}: {
  imports = [
    ./options.nix
    ./zsh
  ];

  my.shell.sessionVariables = {
    EDITOR = "zed";
    GPG_TTY = "$(tty)";
  };

  my.shell.aliases = {
    time = "/usr/bin/time";
  };

  hm.programs.bash = {
    enable = true;
    shellAliases = config.my.shell.aliases;
    sessionVariables = config.my.shell.sessionVariables;
    bashrcExtra = ''
      set -o vi
    '';
  };
}
