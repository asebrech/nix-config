# Style-10: Simple centered with power controls
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
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        # Day
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A")"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.70)";
          font_size = 90;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
        # Date-Month
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%d %B")"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.70)";
          font_size = 40;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 250";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"- %I:%M -")</span>"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.70)";
          font_size = 20;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 190";
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
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
        # Reboot
        {
          monitor = "";
          text = "󰜉";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.6)";
          font_size = 50;
          onclick = "reboot now";
          position = "0, 100";
          halign = "center";
          valign = "bottom";
        }
        # Power off
        {
          monitor = "";
          text = "󰐥";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.6)";
          font_size = 50;
          onclick = "shutdown now";
          position = "820, 100";
          halign = "left";
          valign = "bottom";
        }
        # Suspend
        {
          monitor = "";
          text = "󰤄";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.6)";
          font_size = 50;
          onclick = "systemctl suspend";
          position = "-820, 100";
          halign = "right";
          valign = "bottom";
        }
      ];

      image = [
        {
          monitor = "";
          path = "${config.hostSpec.userAvatar}";
          border_size = 2;
          border_color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.65)";
          size = 130;
          rounding = -1;
          rotate = 0;
          position = "0, 40";
          halign = "center";
          valign = "center";
        }
      ];

      shape = [
        {
          monitor = "";
          size = "300, 60";
          color = "rgba(${colors.base02-rgb-r}, ${colors.base02-rgb-g}, ${colors.base02-rgb-b}, 0.1)";
          rounding = -1;
          border_size = 0;
          position = "0, -130";
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
          position = "0, -210";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
