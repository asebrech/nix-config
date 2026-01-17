# Gaming monitor configuration
# High refresh rate focus
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      ",preferred,auto,1,vrr,1"
    ];
  };
}
