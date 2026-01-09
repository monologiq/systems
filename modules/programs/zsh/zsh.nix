{ inputs, ... }:
{
  flake.modules.nixos.zsh =
    { config, pkgs, ... }:
    {
      imports = [
        inputs.self.modules.nixos.direnv
      ];

      programs.zsh.enable = true;

      programs.zsh.autosuggestions.enable = true;
      programs.zsh.syntaxHighlighting.enable = true;

      users.users = config.machine.users.forAll {
        shell = pkgs.zsh;
      };
    };
}
