# Standard decorations from ML4W
# Based on: https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 10;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
      };

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };
  };
}
