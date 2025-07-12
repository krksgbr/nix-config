{pkgs, ...}: {
  hm.programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batman # View man pages through bat
    ];
  };
  my.shell.aliases.cat = ''bat --theme="Solarized (dark)"'';
}
