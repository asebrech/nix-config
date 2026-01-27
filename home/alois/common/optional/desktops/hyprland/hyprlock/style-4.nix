# Style-4: Centered with profile and name
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
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = false;
      };

      background = lib.mkForce [
        {
          monitor = "";
          path = "${config.stylix.image}";
          blur_passes = 0;
          contrast = 0.8916;
          brightness = 0.8916;
          vibrancy = 0.8916;
          vibrancy_darkness = 0.0;
        }
      ];

      image = [
        {
          monitor = "";
          path = "${config.hostSpec.userAvatar}";
          border_size = 2;
          border_color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.80)";
          size = 100;
          rounding = -1;
          rotate = 0;
          position = "25, 200";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.80)";
          font_size = 60;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "30, -8";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.80)";
          font_size = 19;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "35, -60";
          halign = "center";
          valign = "center";
        }
        # User
        {
          monitor = "";
          text = "    $USER";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.80)";
          font_size = 16;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "38, -190";
          halign = "center";
          valign = "center";
        }
      ];

      shape = [
        {
          monitor = "";
          size = "320, 55";
          color = "rgba(${colors.base02-rgb-r}, ${colors.base02-rgb-g}, ${colors.base02-rgb-b}, 0.1)";
          rounding = -1;
          border_size = 0;
          position = "34, -190";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = lib.mkForce [
        {
          monitor = "";
          size = "320, 55";
          outline_thickness = 0;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(${colors.base00-rgb-r}, ${colors.base00-rgb-g}, ${colors.base00-rgb-b}, 0)";
          inner_color = "rgba(${colors.base02-rgb-r}, ${colors.base02-rgb-g}, ${colors.base02-rgb-b}, 0.1)";
          font_color = "rgb(${colors.base05})";
          font_family = config.stylix.fonts.sansSerif.name;
          fade_on_empty = false;
          placeholder_text = ''<i><span foreground="##${colors.base05}99">🔒  Enter Pass</span></i>'';
          hide_input = false;
          position = "34, -268";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
