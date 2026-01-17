{ ... }:
{
  # Let Stylix handle all theming (colors, wallpaper, fonts)
  stylix.targets.hyprlock = {
    enable = true;
    useWallpaper = true;
  };

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

      animations = {
        enabled = false;
      };

      # Additional input-field configuration (Stylix provides base config)
      input-field = [
        {
          monitor = "";
          size = "650, 100";
          position = "0, 0";
          halign = "center";
          valign = "center";

          outline_thickness = 4;

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
