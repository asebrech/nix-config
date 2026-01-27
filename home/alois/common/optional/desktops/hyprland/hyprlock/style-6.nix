# Style-6: macOS-inspired with Touch ID style and song details
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
          blur_passes = 0;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        # Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.65)";
          font_size = 22;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 420";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.65)";
          font_size = 90;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
        # User name
        {
          monitor = "";
          text = "$USER";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.65)";
          font_size = 22;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 30";
          halign = "center";
          valign = "center";
        }
        # Password label
        {
          monitor = "";
          text = "Password:";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.55)";
          font_size = 17;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "-90, -70";
          halign = "center";
          valign = "center";
        }
        # Touch ID hint
        {
          monitor = "";
          text = "Touch Id or Enter Password";
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.55)";
          font_size = 14;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "-33, -190";
          halign = "center";
          valign = "center";
        }
        # Current song
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(${songDetailScript})"'';
          color = "rgba(${colors.base05-rgb-r}, ${colors.base05-rgb-g}, ${colors.base05-rgb-b}, 0.55)";
          font_size = 17;
          font_family = config.stylix.fonts.monospace.name;
          position = "0, 30";
          halign = "center";
          valign = "bottom";
        }
      ];

      image = [
        {
          monitor = "";
          path = "${config.hostSpec.userAvatar}";
          border_size = 0;
          border_color = "rgba(${colors.base0D-rgb-r}, ${colors.base0D-rgb-g}, ${colors.base0D-rgb-b}, 0)";
          size = 105;
          rounding = 0;
          rotate = 0;
          position = "-105, 30";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = lib.mkForce [
        {
          monitor = "";
          size = "350, 40";
          rounding = 0;
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(${colors.base03-rgb-r}, ${colors.base03-rgb-g}, ${colors.base03-rgb-b}, 1)";
          inner_color = "rgba(${colors.base01-rgb-r}, ${colors.base01-rgb-g}, ${colors.base01-rgb-b}, 1)";
          font_color = "rgb(${colors.base05})";
          font_family = config.stylix.fonts.sansSerif.name;
          fade_on_empty = false;
          placeholder_text = ''<i><span foreground="##${colors.base05}99"></span></i>'';
          hide_input = false;
          position = "30, -125";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
