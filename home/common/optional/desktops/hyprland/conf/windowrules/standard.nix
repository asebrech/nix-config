# Standard window rules from ML4W
# Based on: https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Suppress maximize events for all windows
      "suppressevent maximize, class:.*"

      # Default opacity for better aesthetics
      "opacity 0.95 0.85, class:.*"

      # Fix dragging issues with XWayland
      "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"

      # Float specific window types
      "float, class:(floating)"
      "float, class:(pavucontrol)"
      "float, title:(Picture-in-Picture)"

      # Dialogs should float
      "float, class:(.*), title:(Open File)"
      "float, class:(.*), title:(Save File)"

      # Rofi/launcher windows
      "float, class:(rofi)"
      "stayfocused, class:(rofi)"

      # System dialogs
      "float, class:(org.kde.polkit-kde-authentication-agent-1)"
    ];
  };
}
