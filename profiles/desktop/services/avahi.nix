{
  flake.modules.nixos.profiles-desktop = {
    services.avahi.enable = true;
  };
}
