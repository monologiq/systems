{
  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { ... }:
      {
        imports = [
          (inputs.import-tree [
            ./lib
            ./modules
            ./machines
            ./profiles
          ])

          (inputs.flake-parts.flakeModules.modules or { })
        ];

        systems = [
          "aarch64-darwin"
          "aarch64-linux"
          "x86_64-darwin"
          "x86_64-linux"
        ];

        perSystem =
          { config, pkgs, ... }:
          {
            formatter = pkgs.nixfmt-rfc-style;

            devShells.default = pkgs.mkShell {
              nativeBuildInputs = with pkgs; [
                config.formatter
                nixd
              ];
            };
          };
      }
    );
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs-lib";

    nixpkgs-lib.follows = "nixpkgs";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    import-tree.url = "github:vic/import-tree";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    apple-fonts.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote?ref=master";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };
}
