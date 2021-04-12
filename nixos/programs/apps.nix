{ pkgs, ... }:
let
  wrapChromiumApp = { app, name }:
    pkgs.symlinkJoin {
      inherit name;
      paths = [ app ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/${name} \
          --add-flags "--force-device-scale-factor=2"
      '';
    };
in
{
  environment.systemPackages = with pkgs; [

    capture
    mpv
    peek
    transmission_gtk
    firefox
    # unstable.skype
    zoom-us

    (
      wrapChromiumApp {
        name = "chromium";
        app = chromium;
      }
    )

    (
      wrapChromiumApp {
        name = "slack";
        app = slack;
      }
    )

    (
      wrapChromiumApp {
        name = "spotify";
        app = spotify;
      }
    )

    (
      makeDesktopItem {
        name = "calendar";
        exec = "chromium --app=https://calendar.google.com";
        comment = "Google Calendar";
        desktopName = "Calendar";
      }
    )

    (
      makeDesktopItem {
        name = "Notion";
        exec = "chromium --app=https://www.notion.so";
        comment = "Notion";
        desktopName = "Notion";
      }
    )
    (
      makeDesktopItem {
        name = "Tidal";
        exec = "chromium --app=https://tidal.com";
        comment = "Music Streaming";
        desktopName = "Tidal";
      }
    )

  ];
}
