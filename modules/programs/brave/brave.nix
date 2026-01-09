{ inputs, ... }:

{
  flake.modules.nixos.brave =
    { config, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        brave
      ];
    };
}
