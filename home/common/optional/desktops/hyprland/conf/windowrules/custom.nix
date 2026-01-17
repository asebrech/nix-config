# Custom window rules
# Add your own window-specific rules here
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Add your custom window rules here
      # Example:
      # "workspace 2, class:(firefox)"
      # "fullscreen, class:(gamescope)"
    ];
  };
}
