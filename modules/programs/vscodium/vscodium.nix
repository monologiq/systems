{  ... }:

{
  flake.modules.nixos.vscodium =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (vscode-with-extensions.override {
          vscode = vscodium;
          vscodeExtensions = with vscode-extensions; [
            asvetliakov.vscode-neovim
            jnoortheen.nix-ide
            mkhl.direnv
            yzhang.markdown-all-in-one
          ];
        })
      ];
    };
}
