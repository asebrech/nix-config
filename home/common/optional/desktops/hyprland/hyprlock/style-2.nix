# Style-2: Centered with large clock outline
# Adapted from Hyprlock-Styles by MrVivekRajan
{
  config,
  lib,
  ...
}:
let
  colors = config.lib.stylix.colors;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = lib.mkForce [
        {
          monitor = "";
          path = "${config.stylix.image}";
          blur_passes = 0;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        # Time (large centered)
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.7)";
          font_size = 160;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 370";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.7)";
          font_size = 28;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 490";
          halign = "center";
          valign = "center";
        }
        # User
        {
          monitor = "";
          text = "    $USER";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.80)";
          font_size = 18;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, -180";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = lib.mkForce [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(${colors.base00-rgb-r}, ${colors.base00-rgb-g}, ${colors.base00-rgb-b}, 0)";
          inner_color = "rgba(${colors.base02-rgb-r}, ${colors.base02-rgb-g}, ${colors.base02-rgb-b}, 0.1)";
          font_color = "rgb(${colors.base05})";
          font_family = config.stylix.fonts.sansSerif.name;
          fade_on_empty = false;
          placeholder_text = ''<i><span foreground="##${colors.base05}99">🔒 Enter Pass</span></i>'';
          hide_input = false;
          position = "0, -250";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
