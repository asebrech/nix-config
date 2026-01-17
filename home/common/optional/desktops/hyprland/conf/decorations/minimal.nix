# Minimal decorations
# Reduced effects for clean look
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
