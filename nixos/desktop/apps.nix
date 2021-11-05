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
    let
      launchSiteInChromium = pkgs.writeShellScript "launch-site-in-chromium" ''
        ${pkgs.chromium}/bin/chromium --app=${url} &
        sleep 2
        ${pkgs.xdotool}/bin/xdotool search -classname ${name} set_window --class ${name}
      '';
    in
    pkgs.makeDesktopItem {
      inherit name;
      exec = launchSiteInChromium;
      comment = "Opens ${url}";
      desktopName = name;
    };
in
{
  hm.home.packages = with pkgs; [
    anki
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
    # (wrapChromiumApp spotify "spotify")
    (wrapChromiumApp zoom-us "zoom")

    (wrapSite "Calendar" "https://calendar.google.com")
    (wrapSite "Notion" "https://www.notion.so")
    (wrapSite "Tidal" "https://tidal.com")
    (wrapSite "Todoist" "https://todoist.com")

  ];

  hm.programs.zathura = {
    enable = true;
  };
}
