{ config, ... }:
{
  programs.hyprlock = {
    enable = true;
    importantPrefixes = [
      "$"
      "monitor"
      "size"
      "source"
    ];
    settings = {
      general = {
        ignore_empty_input = true;
      };

      background = [
        {
          monitor = "";
          path = "${config.stylix.image}"; # Stylix wallpaper
          blur_passes = 3;
        }
      ];

      animations = {
        enabled = false;
      };

      input-field = [
        {
          monitor = "";
          size = "650, 100";
          position = "0, 0";
          halign = "center";
          valign = "center";

          # Colors handled by Stylix
          outline_thickness = 4;

          font_family = config.stylix.fonts.monospace.name;

          placeholder_text = "Enter Password";
          fail_text = "<i>$FAIL ($ATTEMPTS)</i>";

          rounding = 0;
          shadow_passes = 0;
          fade_on_empty = false;
        }
      ];

      auth = {
        "fingerprint:enabled" = true;
      };
    };
  };
}
