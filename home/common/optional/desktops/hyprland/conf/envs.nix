# ML4W environment variables
# Based on: https://github.com/mylinuxforwork/dotfiles
# Adapted for 4K@2x scaling
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
      # XDG Desktop Portal
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"

      # Qt
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_QPA_PLATFORMTHEME,qt6ct"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"

      # GDK (adjusted for 4K@2x)
      "GDK_SCALE,2"
      "GDK_DPI_SCALE,0.5"

      # Toolkit Backend
      "GDK_BACKEND,wayland,x11,*"
      "CLUTTER_BACKEND,wayland"

      # Mozilla
      "MOZ_ENABLE_WAYLAND,1"

      # Cursor size (adjusted for 4K@2x)
      "XCURSOR_SIZE,48"
      "HYPRCURSOR_SIZE,48"

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
