# Style-9: Clean centered with profile and song details
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
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%H:%M")</span>"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.70)";
          font_size = 130;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 240";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %d %B")"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.70)";
          font_size = 30;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 105";
          halign = "center";
          valign = "center";
        }
        # User greeting
        {
          monitor = "";
          text = "Hi, $USER";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.70)";
          font_size = 25;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, -130";
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

      image = [
        {
          monitor = "";
          path = "${config.hostSpec.userAvatar}";
          border_color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 1)";
          border_size = 0;
          size = 120;
          rounding = -1;
          rotate = 0;
          position = "0, -20";
          halign = "center";
          valign = "center";
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
          inner_color = "rgba(${colors.base03-rgb-r}, ${colors.base03-rgb-g}, ${colors.base03-rgb-b}, 0.4)";
          font_color = "rgb(${colors.base05})";
          font_family = config.stylix.fonts.sansSerif.name;
          fade_on_empty = false;
          placeholder_text = ''<i><span foreground="##${colors.base05}99">Enter Pass</span></i>'';
          hide_input = false;
          position = "0, -225";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
