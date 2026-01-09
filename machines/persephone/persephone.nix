{ inputs, ... }:
{
  flake.machines.persephone = {
    system = "x86_64-linux";
    profile = "desktop";
    timeZone = "Europe/Paris";
    users.users = {
      pml = "admin";
      guest = "guest";
    };
  };

  flake.modules.nixos.persephone = {
    imports = with inputs.self.modules.nixos; [
      hardware-bluetooth
      hardware-cpu-intel
      hardware-gpu-intel
      hardware-gpu-nvidia
      hardware-openrgb
      hardware-wifi
    ];

    system.stateVersion = "25.11";
  };
}
