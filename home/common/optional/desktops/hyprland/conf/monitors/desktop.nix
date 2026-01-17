# Desktop multi-monitor configuration
# Example configuration for multiple monitors
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-1,2560x1440@144,0x0,1"
      "DP-2,2560x1440@144,2560x0,1"
      "HDMI-A-1,1920x1080@60,5120x0,1"
    ];
  };
}
