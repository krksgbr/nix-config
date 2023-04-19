{ config, lib, pkgs, ... }:
{
  hm.programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
  };

  hm.home.packages = with pkgs; [
    stylua
    tree-sitter
    rnix-lsp

    pkgs.unstable.lua-language-server
    nodePackages.pyright
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.bash-language-server

    # install these through yarn
    # nodePackages.vscode-json-languageserver-bin
    # nodePackages.vscode-html-languageserver-bin
    # nodePackages.vscode-css-languageserver-bin
    coursier
  ];
}
