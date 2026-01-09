{ ... }:
{
  flake.modules.nixos.gimp =
    { config, pkgs, ... }:
    {
      users.users = config.machine.users.forAll {
        packages = with pkgs; [ gimp ];
      };
    };
}
