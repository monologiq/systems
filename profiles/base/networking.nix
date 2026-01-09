{ inputs, ... }:

{
  flake.modules.nixos.profiles-base = 
    { lib, ... }:
    {
      networking.useDHCP = lib.mkDefault true;
    };
}
