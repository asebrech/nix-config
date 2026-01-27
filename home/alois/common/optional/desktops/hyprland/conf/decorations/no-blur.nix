# No Blur decorations
# Adapted from ML4W dotfiles: no-blur.conf
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
        enabled = false;
      };

      shadow = {
        enabled = true;
        range = 30;
        render_power = 3;
      };
    };
  };
}
