{ pkgs, inputs, config, ... }: {
  homebrew = {
    enable = true;
  };

  hm.home.sessionPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/Cellar"
  ];

  my.shell.sessionVariables = {
    GSETTINGS_SCHEMA_DIR = "/opt/homebrew/share/glib-2.0/schemas/";
  };

}
