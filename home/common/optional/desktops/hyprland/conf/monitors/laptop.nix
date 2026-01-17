# Laptop monitor configuration
# Single screen auto-detect
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      ",preferred,auto,1"
    ];
  };
}
