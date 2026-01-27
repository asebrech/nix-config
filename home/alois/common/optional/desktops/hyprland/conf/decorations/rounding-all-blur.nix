# Rounding All Blur decorations
# Adapted from ML4W dotfiles: rounding-all-blur.conf
# https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 10;
      active_opacity = 0.9;
      inactive_opacity = 0.6;
      fullscreen_opacity = 0.9;

      blur = {
        enabled = true;
        size = 3;
        passes = 4;
        new_optimizations = true;
        ignore_opacity = true;
        xray = true;
      };

      shadow = {
        enabled = true;
        range = 30;
        render_power = 3;
      };
    };

    layerrule = [ "blur, waybar" ];
  };
}
