# Hyprlock - Lock screen
# Layout from ML4W, colors handled by Stylix
{ config, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
      };

      # Labels (ML4W layout)
      label = [
        # Day-Month-Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          font_size = 25;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          font_size = 120;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 250";
          halign = "center";
          valign = "center";
        }
        # User label
        {
          monitor = "";
          text = "    $USER";
          font_size = 18;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      # User box shape
      shape = [
        {
          monitor = "";
          size = "300, 60";
          rounding = -1;
          border_size = 0;
          rotate = 0;
          xray = false;
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      # Input field (layout only, Stylix handles colors)
      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          fade_on_empty = false;
          font_family = config.stylix.fonts.sansSerif.name;
          placeholder_text = ''<i><span>Enter Password</span></i>'';
          hide_input = false;
          position = "0, -210";
          halign = "center";
          valign = "center";
        }
      ];

      # Animations
      animations = {
        enabled = true;
      };

      # Authentication
      auth = {
        "fingerprint:enabled" = true;
      };
    };
  };
}
