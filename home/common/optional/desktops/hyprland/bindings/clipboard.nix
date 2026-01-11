{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Copy / Paste - Universal shortcuts
    bind = [
      "SUPER, C, exec, wl-copy"
      "SUPER, V, exec, wl-paste"
      "SUPER CTRL, V, exec, rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'"
    ];
  };
}
