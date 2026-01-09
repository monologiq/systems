{ inputs, ... }:

{
  flake.modules.nixos.firefox =
    { pkgs, ... }:
    {
      programs.firefox.enable = true;
      programs.firefox.nativeMessagingHosts.packages = with pkgs; [ vdhcoapp ];
    };
}
