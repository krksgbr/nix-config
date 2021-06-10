{ pkgs, ... }:
let
  wrapChromiumApp = app: name:
    pkgs.symlinkJoin {
      inherit name;
      paths = [ app ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/${name} \
          --add-flags "--force-device-scale-factor=2"
      '';
    };
  wrapSite = name: url:
    pkgs.makeDesktopItem {
      inherit name;
      exec = "chromium --app=${url}";
      comment = "Opens ${url}";
      desktopName = name;
    };
in
{
  hm.home.packages = with pkgs; [
    capture
    mpv
    peek
    transmission_gtk
    firefox
    signal-desktop
    skype
    gnome3.nautilus
    gnome3.sushi # file previewer for nautilus
    audacity
    flameshot

    (wrapChromiumApp chromium "chromium")
    (wrapChromiumApp slack "slack")
    (wrapChromiumApp spotify "spotify")
    (wrapChromiumApp zoom-us "zoom")

    (wrapSite "Calendar" "https://calendar.google.com")
    (wrapSite "Notion" "https://www.notion.so")
    (wrapSite "Tidal" "https://tidal.com")

  ];

  hm.programs.zathura = {
    enable = true;
  };
}
