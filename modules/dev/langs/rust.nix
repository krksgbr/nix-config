{ config, lib, pkgs, ... }:
{
  hm.home.packages = with pkgs; [
    # Rust
    rustc
    rustfmt
    cargo
    cargo-watch
    rust-analyzer
  ];
}
