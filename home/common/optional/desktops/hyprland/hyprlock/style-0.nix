# Style-0: ML4W-inspired lock screen (original)
# Layout from ML4W dotfiles with Stylix colors
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
        ignore_empty_input = true;
      };

      # Input field - ML4W layout with Stylix colors
      input-field = lib.mkForce [
        {
          monitor = "";
          size = "200, 50";
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          dots_rounding = -1;
          inner_color = "rgb(${colors.base02})";
          font_color = "rgb(${colors.base05})";
          font_family = config.stylix.fonts.sansSerif.name;
          outer_color = "rgb(${colors.base0D})";
          outline_thickness = 3;
          fade_on_empty = true;
          fade_timeout = 1000;
          placeholder_text = "<i>Input Password...</i>";
          hide_input = false;
          rounding = 10;
          check_color = "rgb(${colors.base0D})";
          fail_color = "rgb(${colors.base08})";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = -1;
          numlock_color = -1;
          bothlock_color = -1;
          invert_numlock = false;
          swap_font_color = false;
          position = "0, -20";
          halign = "center";
          valign = "center";
          shadow_passes = 10;
          shadow_size = 20;
          shadow_color = "rgb(${colors.base00})";
          shadow_boost = 1.6;
        }
      ];

      label = [
        # Clock (top right)
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$TIME"'';
          color = "rgb(${colors.base0D})";
          font_size = 70;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "-50, 20";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
          shadow_color = "rgb(${colors.base00})";
        }
        # User (below clock)
        {
          monitor = "";
          text = "$USER";
          color = "rgb(${colors.base05})";
          font_size = 20;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "-50, 120";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
          shadow_color = "rgb(${colors.base00})";
        }
      ];

      # Profile image
      image = [
        {
          monitor = "";
          path = "${config.hostSpec.userAvatar}";
          size = 280;
          rounding = 40;
          border_size = 4;
          border_color = "rgb(${colors.base0D}) rgb(${colors.base0E}) 90deg";
          rotate = 0;
          reload_time = -1;
          position = "0, 200";
          halign = "center";
          valign = "center";
          shadow_passes = 10;
          shadow_size = 20;
          shadow_color = "rgb(${colors.base00})";
          shadow_boost = 1.6;
        }
      ];
    };
  };
}
