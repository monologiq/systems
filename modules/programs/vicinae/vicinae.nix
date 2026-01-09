{
  flake.modules.nixos.vicinae =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = [ pkgs.vicinae ];

      systemd.user.services.vicinae = {
        enable = true;
        path = [ pkgs.vicinae ];

        description = "Vicinae Launcher";
        after = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];

        serviceConfig = {
          Type = "simple";
          ExecStart = "${lib.getExe pkgs.vicinae} server";
          Restart = "on-failure";
          RestartSec = "5s";
        };

        wantedBy = [ "default.target" ];
      };
    };
}
