{ inputs, ... }:

{
  flake.modules.nixos.bitwarden =
    { config, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bitwarden-cli
        bitwarden-desktop
      ];
    };
}
