{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.udiskie
  ];

  # TODO fix this
  # systemd.user.services.udiskie = {
  #   enable = true;
  #   description = "udiskie to automount media";
  #   after =  ["graphical-session-pre.target"];
  #   wantedBy = ["default.target"];
  #   partOf = ["graphical-session.target"];
  #   serviceConfig = {
  #     Type="forking";
  #     Restart = "always";
  #     ExecStart = "${pkgs.udiskie}/bin/udiskie --automount --notify --no-file-manager";
  #   };
  # };

}
