{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

    # Suppress maximize events for all windows (Hyprland 0.53+ syntax)
    windowrule = [
      "suppress_event maximize, match:class .*"

      # Slight opacity by default for better aesthetics
      "opacity 0.97 0.9, match:class .*"

      # Fix dragging issues with XWayland
      "nofocus, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0"
    ];
  };
}
