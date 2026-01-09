{ inputs, ... }:

{
  flake.modules.nixos.profiles-base =
    { pkgs, ... }:
    {
      boot.loader.efi.efiSysMountPoint = "/efi";

      boot.loader.systemd-boot.enable = true;
    };
}
