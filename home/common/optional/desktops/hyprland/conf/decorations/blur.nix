# Enhanced blur decorations
# More aggressive blur effects for aesthetics
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 12;

      shadow = {
        enabled = true;
        range = 8;
        render_power = 3;
      };

      blur = {
        enabled = true;
        size = 8;
        passes = 3;
        vibrancy = 0.2;
        special = true;
        brightness = 0.80;
        contrast = 0.85;
      };
    };
  };
}
