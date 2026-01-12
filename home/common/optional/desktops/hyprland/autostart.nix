{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Notification daemon (dunst instead of mako)
      "dunst"

      # Status bar
      "waybar"

      # Clipboard manager
      "[workspace 1 silent] copyq"

      # Polkit authentication agent
      "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"

      # Systemd environment import for proper app launching
      "systemctl --user import-environment PATH"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    ];
  };
}
