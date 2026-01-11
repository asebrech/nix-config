{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Cursor size
    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"

      # Force all apps to use Wayland
      "GDK_BACKEND,wayland,x11,*"
      "QT_QPA_PLATFORM,wayland;xcb"
      "SDL_VIDEODRIVER,wayland"
      "MOZ_ENABLE_WAYLAND,1"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      "OZONE_PLATFORM,wayland"
      "XDG_SESSION_TYPE,wayland"

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
