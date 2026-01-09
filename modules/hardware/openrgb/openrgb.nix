{ inputs, ... }:
let
  openrgb = import ./_openrgb.nix;
in
{
  flake.overlays = { inherit openrgb; };

  flake.modules.nixos.hardware-openrgb =
    { lib, pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.self.overlays.openrgb ];

      boot.blacklistedKernelModules = [ "spd5118" ];
      boot.kernelModules = [ "i2c-dev" ];

      hardware.i2c.enable = true;

      environment.systemPackages = [ pkgs.i2c-tools ];

      services.hardware.openrgb = {
        enable = true;
        startupProfile = "off";
      };

      services.udev.packages = [ pkgs.openrgb ];

      system.activationScripts.openrgbOff = ''
        mkdir -p /var/lib/OpenRGB
        cp ${./off.orp} /var/lib/OpenRGB/off.orp
        chmod 0644 /var/lib/OpenRGB/off.orp
      '';
    };
}
