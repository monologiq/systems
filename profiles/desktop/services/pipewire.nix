{ inputs, ... }:

{
  flake.modules.nixos.profiles-desktop =
    { pkgs, ... }:
    {
      services.pipewire = {
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };

      security.rtkit.enable = true;
    };
}
