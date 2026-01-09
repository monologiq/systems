{ inputs, ... }:

{
  flake.modules.nixos.hardware-bluetooth =
    { pkgs, ... }:
    {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.settings = {
        General.Experimental = true;
      };
    };
}
