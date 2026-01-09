{ config, inputs, ... }:

{
  flake.modules.nixos.regreet =
    { lib, pkgs, ... }:
    {
      programs.regreet = {
        enable = true;
        font.name = "SF Pro";
        font.size = 16;
        settings = {
          GTK = {
            font_name = lib.mkForce "SF Pro 16";
          };
        };
      };
    };
}
