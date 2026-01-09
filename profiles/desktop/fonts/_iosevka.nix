final: prev: {
  iosevka = prev.iosevka;
  # .overrideAttrs (_: {
  #   privateBuildPlan = {
  #     family = "Iosevka";
  #     spacing = "normal";
  #     serifs = "sans";
  #     noCvSs = false;
  #     exportGlyphNames = true;

  #     variants.inherits = "ss08";

  #     variants.weights.Regular = {
  #       shape = 400;
  #       menu = 400;
  #       css = 400;
  #     };

  #     variants.weights.Bold = {
  #       shape = 700;
  #       menu = 700;
  #       css = 700;
  #     };

  #     variants.weights.Italic = {
  #       angle = 9.4;
  #       shape = "italic";
  #       menu = "italic";
  #       css = "italic";
  #     };

  #     variants.weights.Upright = {
  #       angle = 0;
  #       shape = "upright";
  #       menu = "upright";
  #       css = "upright";
  #     };
  #   };
  # });
}
