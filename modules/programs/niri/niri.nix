{ inputs, ... }:

{
  flake.modules.nixos.niri =
    { lib, pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        regreet
        vicinae
      ];

      environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        gsettings-desktop-schemas
        ghostty
        fuzzel
      ];

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };

      programs.niri.enable = true;

      security.polkit.enable = true;
    };
}
