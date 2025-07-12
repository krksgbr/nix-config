{...}: {
  homebrew = {
    enable = true;
  };

  hm.home.sessionPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/Cellar"
  ];
}
