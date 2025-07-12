{pkgs, ...}: {
  hm.home.packages = [
    pkgs.chezmoi
  ];

  hm.programs.zsh.initContent = ''
    # chezmoi completion widget
    eval "$(chezmoi completion zsh)"
  '';
}
