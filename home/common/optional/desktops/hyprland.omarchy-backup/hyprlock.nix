{ config, lib, ... }:
{
  # Style based on: https://github.com/MrVivekRajan/Hyprlock-Styles/tree/main/Style-3
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
      };

      # Style-3 labels
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

      # Input field (Style-3 layout with Stylix colors)
      input-field = lib.mkForce [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          # Use Stylix colors
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(${config.lib.stylix.colors.base00-rgb-r}, ${config.lib.stylix.colors.base00-rgb-g}, ${config.lib.stylix.colors.base00-rgb-b}, 0.5)";
          font_color = "rgb(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b})";
          fade_on_empty = false;
          font_family = config.stylix.fonts.sansSerif.name;
          placeholder_text = ''<i><span foreground="##ffffff99">Enter Pass</span></i>'';
          hide_input = false;
          position = "0, -210";
          halign = "center";
          valign = "center";
        }
      ];

      animations = {
        enabled = false;
      };

      auth = {
        "fingerprint:enabled" = true;
      };
    };
  };
}
