# Style-8: Large split time with accent color and song details
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
        echo "▷ $title - $artist"
      fi
    elif [[ $(${pkgs.playerctl}/bin/playerctl status 2>/dev/null) == "Paused" ]]; then
      title=$(${pkgs.playerctl}/bin/playerctl metadata title 2>/dev/null)
      artist=$(${pkgs.playerctl}/bin/playerctl metadata artist 2>/dev/null)
      if [[ -n "$title" && -n "$artist" ]]; then
        echo " $title - $artist"
      fi
    fi
  '';
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
        # Hour (accent)
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%H")"'';
          color = "rgba(${colors.base0D-rgb-r}, ${colors.base0D-rgb-g}, ${colors.base0D-rgb-b}, 0.6)";
          font_size = 180;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        # Minute (white)
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%M")"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.6)";
          font_size = 180;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 75";
          halign = "center";
          valign = "center";
        }
        # Date (mixed colors)
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span color='##${colors.base05}99'>$(date '+%A, ')</span><span color='##${colors.base0D}99'>$(date '+%d %B')</span>"'';
          font_size = 30;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, -80";
          halign = "center";
          valign = "center";
        }
        # User emoji
        {
          monitor = "";
          text = "";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.65)";
          font_size = 100;
          position = "0, -180";
          halign = "center";
          valign = "center";
        }
        # Current song
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(${songDetailScript})"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.7)";
          font_size = 18;
          font_family = config.stylix.fonts.monospace.name;
          position = "0, 60";
          halign = "center";
          valign = "bottom";
        }
      ];

      input-field = lib.mkForce [
        {
          monitor = "";
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(${colors.base00-rgb-r}, ${colors.base00-rgb-g}, ${colors.base00-rgb-b}, 0)";
          inner_color = "rgba(${colors.base03-rgb-r}, ${colors.base03-rgb-g}, ${colors.base03-rgb-b}, 0.5)";
          font_color = "rgb(${colors.base05})";
          font_family = config.stylix.fonts.sansSerif.name;
          fade_on_empty = false;
          placeholder_text = ''<i><span foreground="##${colors.base05}99">Hi, $USER</span></i>'';
          hide_input = false;
          position = "0, -290";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
