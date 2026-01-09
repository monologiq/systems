{ inputs, ... }:

{
  flake.modules.nixos.hardware-wifi =
    {  ... }:
    {
      networking.wireless.iwd.enable = true;
    };
}
