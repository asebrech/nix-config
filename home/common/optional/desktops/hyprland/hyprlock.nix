{ config, lib, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
      };

      # Day label
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A")"'';
          font_size = 90;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
        # Date-Month label
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%d %B")"'';
          font_size = 40;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 250";
          halign = "center";
          valign = "center";
        }
        # Time label
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"- %I:%M -")</span>"'';
          font_size = 20;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 190";
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
        # Reboot button
        {
          monitor = "";
          text = "󰜉";
          font_size = 50;
          onclick = "reboot now";
          position = "0, 100";
          halign = "center";
          valign = "bottom";
        }
        # Power off button
        {
          monitor = "";
          text = "󰐥";
          font_size = 50;
          onclick = "shutdown now";
          position = "820, 100";
          halign = "left";
          valign = "bottom";
        }
        # Suspend button
        {
          monitor = "";
          text = "󰤄";
          font_size = 50;
          onclick = "systemctl suspend";
          position = "-820, 100";
          halign = "right";
          valign = "bottom";
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

      # Input field (Style-10 layout with Stylix colors)
      input-field = lib.mkForce [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          # Use Stylix colors instead of hardcoded grays
          outer_color = "rgba(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b}, 0)";
          inner_color = "rgba(${config.lib.stylix.colors.base00-rgb-r}, ${config.lib.stylix.colors.base00-rgb-g}, ${config.lib.stylix.colors.base00-rgb-b}, 0.5)";
          font_color = "rgb(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b})";
          fade_on_empty = false;
          font_family = config.stylix.fonts.sansSerif.name;
          placeholder_text = ''<i><span foreground="##ffffff99">🔒 Enter Pass</span></i>'';
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
