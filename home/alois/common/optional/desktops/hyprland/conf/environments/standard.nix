# Standard Wayland environment variables
# Adapted from ML4W dotfiles: ml4w.conf
# https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # XDG Desktop Portal
    env = [
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"

      # QT - Note: QT_QPA_PLATFORMTHEME removed as it conflicts with Stylix
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"

      # Toolkit Backend
      "GDK_BACKEND,wayland,x11,*"
      "CLUTTER_BACKEND,wayland"

      # Mozilla
      "MOZ_ENABLE_WAYLAND,1"

      # Ozone
      "OZONE_PLATFORM,wayland"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"

      # SDL
      "SDL_VIDEODRIVER,wayland"
    ];

    xwayland = {
      force_zero_scaling = true;
    };
  };
}
