# Rounding More Blur decorations
# Adapted from ML4W dotfiles: rounding-more-blur.conf
# https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 10;
      active_opacity = 1.0;
      inactive_opacity = 0.6;
      fullscreen_opacity = 1.0;

      blur = {
        enabled = true;
        size = 12;
        passes = 6;
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
  };
}
