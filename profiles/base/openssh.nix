{
  flake.modules.nixos.profiles-base = {
    services.openssh.enable = true;
  };
}
