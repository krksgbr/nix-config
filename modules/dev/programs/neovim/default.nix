{
  config,
  lib,
  pkgs,
  ...
}: {
  hm.programs.neovim = {
    enable = true;
  };

  hm.home.packages = with pkgs; [
    stylua
    tree-sitter

    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.bash-language-server

    # install these through yarn
    # nodePackages.vscode-json-languageserver-bin
    # nodePackages.vscode-html-languageserver-bin
    # nodePackages.vscode-css-languageserver-bin
    # nodePackages.typescript
    # nodePackages.typescript-language-server
    coursier

    ripgrep # required for grepping with telescope
  ];
}
