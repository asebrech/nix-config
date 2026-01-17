{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Wallpaper with swww
      "${pkgs.swww}/bin/swww-daemon"
      "${pkgs.swww}/bin/swww img ${config.stylix.image}"

      # Notification daemon (dunst is managed by systemd service)
      # Status bar (waybar is managed by systemd service)

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
