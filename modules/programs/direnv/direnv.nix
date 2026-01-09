{ inputs, ... }:
{
  flake.modules.nixos.direnv =
    { config, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        direnv
      ];
    };
}
