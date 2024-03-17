{ pkgs, inputs, config, ... }: {
  homebrew = {
    enable = true;
  };

  hm.home.sessionPath = [
    "/opt/homebrew/bin"
  ];
}
