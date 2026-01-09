{ ... }:

{
  flake.modules.nixos.neovim =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = pkgs.neovimUtils.makeNeovimConfig {
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;

        plugins = with pkgs.vimPlugins; [
          nvim-lspconfig
          nvim-treesitter.withAllGrammars
        ];

        customLuaRc = ''
          local config_path = vim.fn.stdpath('config') .. '/init.lua'
          if vim.fn.filereadable(config_path) == 1 then
            dofile(config_path)
          end
        '';

        wrapRc = false;
      };
    in
    {
      nixpkgs.config.packageOverrides = pkgs: {
        myNeovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (
          cfg
          // {
            wrapperArgs =
              with pkgs;
              " --prefix PATH : ${
                 lib.makeBinPath [
                   ripgrep
                   nixfmt
                   stylua
                 ]
               }";
          }
        );
      };

      environment.sessionVariables = {
        EDITOR = "${lib.getExe pkgs.myNeovim}";
      };

      users.users = config.machine.users.forAll {
        packages = [ pkgs.myNeovim ];
      };
    };
}
