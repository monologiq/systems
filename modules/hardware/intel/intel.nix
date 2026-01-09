{ inputs, ... }:

{
  flake.modules.nixos.hardware-cpu-intel =
    { config, lib, ... }:
    {
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      hardware.enableRedistributableFirmware = true;
    };

  flake.modules.nixos.hardware-gpu-intel =
    { pkgs, ... }:
    {
      boot.kernelModules = [
        "kvm-intel"
      ];

      environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD";
        VDPAU_DRIVER = "va_gl";
      };

      environment.systemPackages = [ pkgs.libva-utils ];

      hardware.graphics.enable = true;

      services.xserver.videoDrivers = [
        "modesetting"
      ];
    };
}
