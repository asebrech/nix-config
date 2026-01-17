# Hyprlock - Lock screen
# Layout from ML4W, colors and input-field handled by Stylix
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

      # Note: input-field is configured by Stylix
      # Stylix will automatically theme and position the input field

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
