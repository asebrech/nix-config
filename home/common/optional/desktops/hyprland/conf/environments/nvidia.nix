# NVIDIA-specific environment variables
# Optimizations for NVIDIA GPUs
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

      # GDK
      "GDK_BACKEND,wayland,x11,*"

      # Toolkit Backend
      "CLUTTER_BACKEND,wayland"

      # Mozilla
      "MOZ_ENABLE_WAYLAND,1"

      # Cursor
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"

      # Ozone
      "OZONE_PLATFORM,wayland"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"

      # SDL
      "SDL_VIDEODRIVER,wayland"

      # NVIDIA-specific
      "LIBVA_DRIVER_NAME,nvidia"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "WLR_NO_HARDWARE_CURSORS,1"
      "WLR_DRM_NO_ATOMIC,1"
    ];

    xwayland = {
      force_zero_scaling = true;
    };
  };
}
