{ ... }:
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
          color = "rgb(0, 0, 0)";
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
          inner_color = "rgb(40, 40, 40)";
          outer_color = "rgb(100, 100, 100)";
          outline_thickness = 4;
          font_family = "JetBrainsMono Nerd Font";
          font_color = "rgb(255, 255, 255)";
          placeholder_text = "Enter Password";
          check_color = "rgb(100, 200, 100)";
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
