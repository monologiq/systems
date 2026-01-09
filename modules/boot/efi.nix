{ inputs, ... }:

{
  flake.modules.nixos.boot-efi =
    { lib, pkgs, ... }:
    {
      imports = [
        (inputs.lanzaboote.nixosModules.lanzaboote or {})
      ];

      boot.bootspec.enable = true;

      boot.initrd.systemd.enable = true;

      boot.kernelPackages = pkgs.linuxPackages_latest;

      boot.lanzaboote.enable = true;
      boot.lanzaboote.pkiBundle = "/var/lib/sbctl";

      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/efi";

      boot.loader.systemd-boot.enable = lib.mkForce false;
      boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

      environment.systemPackages = with pkgs; [
        sbctl
      ];
    };
}
