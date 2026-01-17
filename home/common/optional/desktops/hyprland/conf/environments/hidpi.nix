# HiDPI/4K environment variables
# 2x scaling for 4K displays
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
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_SCALE_FACTOR,2"
      "QT_ENABLE_HIGHDPI_SCALING,1"

      # GDK (2x scaling)
      "GDK_SCALE,2"
      "GDK_DPI_SCALE,0.5"
      "GDK_BACKEND,wayland,x11,*"

      # Toolkit Backend
      "CLUTTER_BACKEND,wayland"

      # Mozilla
      "MOZ_ENABLE_WAYLAND,1"

      # Cursor (larger for HiDPI)
      "XCURSOR_SIZE,48"
      "HYPRCURSOR_SIZE,48"

      # Ozone
      "OZONE_PLATFORM,wayland"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"

      # SDL
      "SDL_VIDEODRIVER,wayland"

      # ELM
      "ELM_SCALE,2"

      # Java apps scaling
      "_JAVA_OPTIONS,-Dsun.java2d.uiScale=2"

      # Wine apps scaling
      "WINE_SCALE,2"
    ];

    xwayland = {
      force_zero_scaling = true;
    };
  };
}
