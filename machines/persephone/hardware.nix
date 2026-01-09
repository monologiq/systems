{ inputs, ... }:
let
  boot = "e012abe7-2b2a-45c8-afc1-5736f3d90f10";
  esp = "6F00-A9CE";
  luks = "ff222f6a-9c95-4275-9003-741d04ba6a1d";
  cryptroot = "0f2390ca-030b-47f5-b109-836a7617558b";
in
{
  flake.modules.nixos.persephone =
    { lib, pkgs, ... }:
    {
      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "ahci"
        "usbhid"
        "sd_mod"
      ];

      hardware.graphics.extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ];

      hardware.nvidia.prime = {
        offload.enable = true;
        offload.enableOffloadCmd = true;
        
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/${boot}";
        fsType = "ext4";
      };

      fileSystems."/efi" = {
        device = "/dev/disk/by-uuid/${esp}";
        fsType = "vfat";
        options = [
          "fmask=0137"
          "dmask=0027"
        ];
      };

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/${cryptroot}";
        fsType = "btrfs";
        options = [ "subvol=@root" ];
      };

      boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/${luks}";

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/${cryptroot}";
        fsType = "btrfs";
        options = [ "subvol=@home" ];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/${cryptroot}";
        fsType = "btrfs";
        options = [ "subvol=@nix" ];
      };

      fileSystems."/var/cache" = {
        device = "/dev/disk/by-uuid/${cryptroot}";
        fsType = "btrfs";
        options = [ "subvol=@var_cache" ];
      };

      fileSystems."/var/log" = {
        device = "/dev/disk/by-uuid/${cryptroot}";
        fsType = "btrfs";
        options = [ "subvol=@var_log" ];
      };

      fileSystems."/var/spool" = {
        device = "/dev/disk/by-uuid/${cryptroot}";
        fsType = "btrfs";
        options = [ "subvol=@var_spool" ];
      };

      fileSystems."/var/tmp" = {
        device = "/dev/disk/by-uuid/${cryptroot}";
        fsType = "btrfs";
        options = [ "subvol=@var_tmp" ];
      };

      fileSystems."/var/lib/machines" = {
        device = "/dev/disk/by-uuid/${cryptroot}";
        fsType = "btrfs";
        options = [ "subvol=@var_lib_machines" ];
      };

      fileSystems."/var/lib/portables" = {
        device = "/dev/disk/by-uuid/${cryptroot}";
        fsType = "btrfs";
        options = [ "subvol=@var_lib_portables" ];
      };

      swapDevices = [ ];
    };
}
