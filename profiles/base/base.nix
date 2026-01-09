{ inputs, ... }:

{
  flake.modules.nixos.profiles-base =
    { lib, pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        neovim
        zsh
      ];

      environment.sessionVariables = {
        PAGER = lib.mkDefault "${lib.getExe pkgs.less}";
      };

      environment.systemPackages = with pkgs; [
        less
        vim
      ];
    };

}
