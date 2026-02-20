# Style-1: Left-aligned layout with song details
# Adapted from Hyprlock-Styles by MrVivekRajan
{
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;

  # Song detail script (playerctl integration)
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
        # Greeting
        {
          monitor = "";
          text = "Welcome!";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.75)";
          font_size = 55;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "150, 320";
          halign = "left";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.75)";
          font_size = 40;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "240, 240";
          halign = "left";
          valign = "center";
        }
        # Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.75)";
          font_size = 19;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "217, 175";
          halign = "left";
          valign = "center";
        }
        # User
        {
          monitor = "";
          text = "    $USER";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.80)";
          font_size = 16;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "275, -140";
          halign = "left";
          valign = "center";
        }
        # Current song
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(${songDetailScript})"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.65)";
          font_size = 14;
          font_family = config.stylix.fonts.monospace.name;
          position = "210, 45";
          halign = "left";
          valign = "bottom";
        }
      ];

      image = [
        {
          monitor = "";
          path = "${config.hostSpec.userAvatar}";
          border_size = 2;
          border_color = "rgba(${colors.base0D-rgb-r}, ${colors.base0D-rgb-g}, ${colors.base0D-rgb-b}, 0.75)";
          size = 95;
          rounding = -1;
          rotate = 0;
          position = "270, 25";
          halign = "left";
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
          position = "160, -140";
          halign = "left";
          valign = "center";
        }
      ];

      input-field = lib.mkForce [
        {
          monitor = "";
          size = "320, 55";
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
          position = "160, -220";
          halign = "left";
          valign = "center";
        }
      ];
    };
  };
}
