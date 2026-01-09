{ inputs, ... }:

{
  flake.modules.nixos.profiles-desktop =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        boot-efi

        bitwarden
        brave
        firefox
        vicinae
        gimp
        mpv
        thunderbird
        vscodium
      ];

      environment.systemPackages = with pkgs; [
        bat
        btop
        ddcutil
        git

        loupe
        qbittorrent
      ];
    };
}
