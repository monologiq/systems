{ inputs, ... }:

{
  flake.modules.nixos.profiles-base =
    { config, ... }:
    {
      imports = [
        (inputs.agenix.nixosModules.default or { })
      ];

      environment.systemPackages = [
        inputs.agenix.packages.${config.machine.system}.default
      ];
    };
}
