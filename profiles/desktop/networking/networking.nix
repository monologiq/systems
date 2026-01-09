{ inputs, ... }:

{
  flake.modules.nixos.profiles-desktop =
    { config, lib, ... }:
    {
      networking.dhcpcd.enable = true;
      networking.dhcpcd.extraConfig = ''
        ${lib.optionalString config.services.resolved.enable "nohook resolv.conf"}
      '';

      networking.resolvconf.enable = !config.services.resolved.enable;
      networking.useDHCP = lib.mkDefault true;

      networking.wireless.iwd.settings = {
        General = {
          EnableNetworkConfiguration = false;
        };
        Network = {
          EnableIPv6 = true;
          NameResolvingService = "systemd";
        };
      };

      services.resolved = {
        enable = true;
        dnssec = "true";
        domains = [ "~." ];
        fallbackDns = [
          "9.9.9.9#dns.quad9.net"
          "149.112.112.112#dns.quad9.net"
          "2620:fe::fe#dns.quad9.net"
          "2620:fe::9#dns.quad9.net"
        ];
        extraConfig = ''
          DNSOverTLS=yes
        '';
      };
    };
}
