{pkgs, ...}: {
  imports = [
    ../shell/options.nix
    ./bat # better `cat`
    ./direnv
    ./eza # better `ls`
    ./fzf
    ./git
    # ./kitty
    ./ghostty
    ./neovim
    #./tmux
    ./zellij # terminal multiplexing
    ./navi # cheatsheets for code and cli tools
    ./chezmoi # dotfile manager
  ];

  hm.home.packages = with pkgs; [
    jq
    curl
    imagemagick
    exiftool
    procs
    just
  ];
}
