{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

    windowrulev2 = [
      # Suppress maximize events for all windows
      "suppressevent maximize, class:.*"

      # Slight opacity by default for better aesthetics
      "opacity 0.97 0.9, class:.*"

      # Fix dragging issues with XWayland
      "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
    ];
  };
}
