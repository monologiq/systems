{ inputs, ... }:
{
  flake.modules.nixos.profiles-base = {
    imports = [
      inputs.determinate.nixosModules.default
    ];
  };
}
