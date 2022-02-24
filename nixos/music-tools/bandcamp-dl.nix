{ config, lib, pkgs, ... }:
let
  # Bulk-downloads bandcamp purchases to remote personal server.
  get-cookies = ./get-cookies.js;
  remote = "plex.krks.info";
  script = pkgs.writeShellApplication {
    name = "bandcamp-dl";
    runtimeInputs = with pkgs; [ sqlite fd ];
    text = ''
      cookies_file="/tmp/bandcamp-dl-cookies.json"

      # 1. Export bandcamp cookies from firefox with get-cookies.js
      #  (this is how the downloader authenticates with bandcamp)

      node ${get-cookies} > $cookies_file

      # 2. Copies cookies file to personal server

      scp $cookies_file gabor@${remote}:$cookies_file
      rm $cookies_file

      # 3. Invoke remote program to start downloading
      # A companion script is installed on the server using:
      # https://github.com/Ezwen/bandcamp-collection-downloader
      ssh gabor@${remote} "bandcamp-dl"
    '';
  };
in
{
  hm.home.packages = [ script ];
}
