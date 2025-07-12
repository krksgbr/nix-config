{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    rustup
  ];

  hm.programs.zsh.initContent = ''
    export PATH="$HOME/.cargo/bin:$PATH"
  '';
}
