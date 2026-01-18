# Cursor configuration
# Adapted from ML4W dotfiles: https://github.com/mylinuxforwork/dotfiles
# Note: Cursor theme is set via Stylix, but this applies it at Hyprland startup
{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Apply cursor theme from Stylix
      "hyprctl setcursor ${config.stylix.cursor.name} ${toString config.stylix.cursor.size}"
    ];
  };
}
