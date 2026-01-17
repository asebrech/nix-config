# Animations disabled
# For better performance or personal preference
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = false;
    };
  };
}
