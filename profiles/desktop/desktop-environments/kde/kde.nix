{ ... }:

{
  flake.modules.nixos.profiles-desktop =
    { pkgs, ... }:
    {

      environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        gsettings-desktop-schemas
        wl-clipboard
      ];

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };

      services.xserver.enable = true;
      
      services.desktopManager.plasma6.enable = true;
      
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;
      services.displayManager.sddm.settings.General.DisplayServer = "wayland";

      security.polkit.enable = true;
    };
}
