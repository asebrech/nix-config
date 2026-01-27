# Blur decorations
# Adapted from ML4W dotfiles: blur.conf
# https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 10;
      active_opacity = 1.0;
      inactive_opacity = 0.9;
      fullscreen_opacity = 1.0;

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
        range = 32;
        render_power = 2;
      };
    };

    layerrule = [ "blur, waybar" ];
  };
}
