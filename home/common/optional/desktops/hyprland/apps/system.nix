{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Floating windows
      "float, tag:floating-window"
      "center, tag:floating-window"
      "size 875 600, tag:floating-window"

      # Tag floating window apps (adapted for your system)
      "tag +floating-window, class:(org.gnome.Calculator|org.gnome.NautilusPreviewer|org.gnome.Evince|com.gabm.satty|imv|mpv)"
      "tag +floating-window, class:(xdg-desktop-portal-gtk|sublime_text|DesktopEditors|org.gnome.Nautilus), title:^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)"
      "float, class:org.gnome.Calculator"

      # No transparency on media windows
      "opacity 1 1, class:^(zoom|vlc|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$"

      # Popped window rounding
      "rounding 8, tag:pop"

      # Prevent idle while open
      "idleinhibit always, tag:noidle"
    ];
  };
}
