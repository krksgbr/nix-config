{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    lua
    lua-language-server
    stylua
  ];
}
