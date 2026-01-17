{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Vicinae launcher server
      "vicinae server"

      # Wallpaper with swww
      "${pkgs.swww}/bin/swww-daemon"
      "${pkgs.swww}/bin/swww img ${config.stylix.image}"

      # Clipboard manager
      "[workspace 1 silent] copyq"
      "wl-paste --watch ${pkgs.cliphist}/bin/cliphist store"

      # Polkit authentication agent
      "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"

      # Hypridle for automatic screen lock
      "${pkgs.hypridle}/bin/hypridle"

      # Systemd environment import for proper app launching
      "systemctl --user import-environment PATH"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    ];
  };
}
