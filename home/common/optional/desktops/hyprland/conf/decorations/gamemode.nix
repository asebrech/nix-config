# Gaming optimizations
# Disabled effects for better performance
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 0;

      shadow = {
        enabled = false;
      };

      blur = {
        enabled = false;
      };
    };
  };
}
