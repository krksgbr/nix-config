{pkgs, ...}: {
  hm.home.packages = [
    pkgs.nixd # language-server
    pkgs.unstable.alejandra # formatter
  ];
}
