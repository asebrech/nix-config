# Autostart applications
# Adapted from ML4W dotfiles: https://github.com/mylinuxforwork/dotfiles
{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Vicinae launcher server
      "vicinae server"

      # Wallpaper daemon and restore
      "${pkgs.swww}/bin/swww-daemon"
      "${pkgs.swww}/bin/swww img ${config.stylix.image}"

      # Polkit authentication agent
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

      # Clipboard history with cliphist
      "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store"
    ];
  };
}
