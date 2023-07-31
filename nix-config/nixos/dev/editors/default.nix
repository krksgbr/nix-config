{ config, lib, pkgs, ... }:
{
  imports = [
    ./idea.nix
    ./vim.nix
    ./emacs.nix
    ./neovim.nix
  ];

  fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];
}
