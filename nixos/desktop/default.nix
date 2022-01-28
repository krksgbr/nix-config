{ pkgs, ... }:
{
  imports = [
    ./display-manager.nix
    ./i3
    ./sound.nix
    ./monitors.nix
    ./locale.nix
    ./touchpad.nix
    ./keyboard.nix
    ./notifications.nix
    ./gammastep.nix
    ./fonts.nix
    ./apps.nix
    ./flatpak.nix
    ./gnome-pomodoro.nix
    ./torrent-client.nix
  ];

  environment.extraInit = ''
    # these are the defaults, but some applications need these to be set explicitly
    export XDG_CONFIG_HOME=$HOME/.config
    export XDG_DATA_HOME=$HOME/.local/share
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share
    export XDG_CACHE_HOME=$HOME/.cache
  '';

  environment.pathsToLink = [ "/share/zsh" "/libexec" ];
  environment.sessionVariables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };

  environment.systemPackages = with pkgs; [
    arc-theme
    arc-icon-theme
    hicolor-icon-theme
    qt5.full
  ];

  services.xserver = {
    enable = true;
  };

  programs.dconf.enable = true;

}
