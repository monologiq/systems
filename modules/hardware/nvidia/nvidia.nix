{
  flake.modules.nixos.hardware-gpu-nvidia =
    { config, pkgs, ... }:
    {
      machine.nixpkgs.allowUnfreePredicate = [
        "nvidia-settings"
        "nvidia-x11"
      ];

      environment.systemPackages = [ pkgs.libva-utils ];

      hardware.nvidia.open = true;
      hardware.nvidia.nvidiaSettings = true;

      nix.settings = {
        substituters = [ "https://cache.nixos-cuda.org" ];
        trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
      };

      services.xserver.videoDrivers = [
        "nvidia"
      ];
    };
}
