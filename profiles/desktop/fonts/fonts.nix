{ inputs, lib, ... }:
# let
#   iosevka = import ./_iosevka.nix { };
# in
{
  # flake.overlays = { inherit iosevka; };

  flake.modules.nixos.profiles-desktop =
    { pkgs, ... }:
    {
      # nixpkgs.overlays = [ inputs.self.overlays.iosevka ];

      fonts.packages = with pkgs; [
        inputs.apple-fonts.packages.${stdenv.hostPlatform.system}.sf-pro
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        (iosevka.override {
          privateBuildPlan = {
            family = "Iosevka";
            spacing = "normal";
            serifs = "sans";
            noCvSs = false;
            exportGlyphNames = true;

            variants.inherits = "ss08";

            variants.weights.Regular = {
              shape = 400;
              menu = 400;
              css = 400;
            };

            variants.weights.Bold = {
              shape = 700;
              menu = 700;
              css = 700;
            };

            variants.weights.Italic = {
              angle = 9.4;
              shape = "italic";
              menu = "italic";
              css = "italic";
            };

            variants.weights.Upright = {
              angle = 0;
              shape = "upright";
              menu = "upright";
              css = "upright";
            };
          };
        })
      ];

      fonts.fontconfig = {
        enable = true;
        antialias = true;
        hinting = {
          enable = true;
          style = "slight";
        };
        subpixel = {
          rgba = "rgb";
          lcdfilter = "default";
        };
        defaultFonts = {
          serif = [
            "SF Pro"
          ];
          sansSerif = [
            "SF Pro"
          ];
          monospace = [
            "Iosevka"
          ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
}
