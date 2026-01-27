# Style-5: Accent time with emoji logo and song details
# Adapted from Hyprlock-Styles by MrVivekRajan
{
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;

  songDetailScript = pkgs.writeShellScript "songdetail.sh" ''
    if [[ $(${pkgs.playerctl}/bin/playerctl status 2>/dev/null) == "Playing" ]]; then
      title=$(${pkgs.playerctl}/bin/playerctl metadata title 2>/dev/null)
      artist=$(${pkgs.playerctl}/bin/playerctl metadata artist 2>/dev/null)
      if [[ -n "$title" && -n "$artist" ]]; then
        echo "♫ $title - $artist"
      fi
    fi
  '';
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
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        # Time (accent color)
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
          color = "rgba(${colors.base0D-rgb-r}, ${colors.base0D-rgb-g}, ${colors.base0D-rgb-b}, 0.75)";
          font_size = 120;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, -140";
          halign = "center";
          valign = "top";
        }
        # Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.75)";
          font_size = 30;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        # Logo emoji
        {
          monitor = "";
          text = " ";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.65)";
          font_size = 120;
          position = "0, 60";
          halign = "center";
          valign = "center";
        }
        # User greeting
        {
          monitor = "";
          text = "Hello, $USER";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.65)";
          font_size = 25;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, -70";
          halign = "center";
          valign = "center";
        }
        # Current song
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(${songDetailScript})"'';
          color = "rgba(${colors.base0D-rgb-r}, ${colors.base0D-rgb-g}, ${colors.base0D-rgb-b}, 0.75)";
          font_size = 16;
          font_family = config.stylix.fonts.monospace.name;
          position = "0, 80";
          halign = "center";
          valign = "bottom";
        }
      ];

      input-field = lib.mkForce [
        {
          monitor = "";
          size = "290, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(${colors.base00-rgb-r}, ${colors.base00-rgb-g}, ${colors.base00-rgb-b}, 0)";
          inner_color = "rgba(${colors.base02-rgb-r}, ${colors.base02-rgb-g}, ${colors.base02-rgb-b}, 0.35)";
          font_color = "rgb(${colors.base05})";
          font_family = config.stylix.fonts.sansSerif.name;
          fade_on_empty = false;
          placeholder_text = ''<i><span foreground="##${colors.base05}99">Use Me</span></i>'';
          hide_input = false;
          position = "0, -140";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
