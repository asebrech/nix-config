{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Cursor size (scaled for 2x display)
    env = [
      "XCURSOR_SIZE,48"
      "HYPRCURSOR_SIZE,48"

      # Scaling for GUI apps (2x for 4K with 2.0 monitor scale)
      "GDK_SCALE,2"
      "GDK_DPI_SCALE,0.5"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_SCALE_FACTOR,2"
      "QT_ENABLE_HIGHDPI_SCALING,1"
      "ELM_SCALE,2"

      # Java apps scaling
      "_JAVA_OPTIONS,-Dsun.java2d.uiScale=2"

      # Wine apps scaling
      "WINE_SCALE,2"

      # Force all apps to use Wayland
      "GDK_BACKEND,wayland,x11,*"
      "QT_QPA_PLATFORM,wayland;xcb"
      "CLUTTER_BACKEND,wayland"
      "SDL_VIDEODRIVER,wayland"
      "MOZ_ENABLE_WAYLAND,1"
      "NIXOS_OZONE_WL,1"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      "OZONE_PLATFORM,wayland"
      "XDG_SESSION_TYPE,wayland"
      "WLR_NO_HARDWARE_CURSORS,1"

      # Allow better support for screen sharing (Google Meet, Discord, etc)
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"

      # Use XCompose file
      "XCOMPOSEFILE,~/.XCompose"
    ];

    xwayland = {
      force_zero_scaling = true;
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };
  };
}
