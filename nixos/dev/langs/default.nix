{ config, lib, pkgs, ... }:
{
  imports = [
    ./elm.nix
    ./haskell.nix
    ./node.nix
  ];

  hm.home.packages = with pkgs; [
    lua
    # Rust
    rustc
    rustfmt
    cargo
    cargo-watch
    rust-analyzer
  ];

}
