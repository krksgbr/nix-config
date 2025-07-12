{pkgs, ...}: {
  hm.home.packages = [
    pkgs.git
    pkgs.gitAndTools.delta
    pkgs.git-lfs
  ];

  hm.programs.zsh.initContent = ''
    export PATH="$HOME/.config/git/scripts:$PATH"
  '';

  my.shell.aliases = {
    g = "git";
  };
}
