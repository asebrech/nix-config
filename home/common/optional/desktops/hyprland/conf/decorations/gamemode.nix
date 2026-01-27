# Gamemode decorations (performance mode)
# Adapted from ML4W dotfiles: gamemode.conf
# https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 0;
      active_opacity = 1.0;
      inactive_opacity = 0.9;
      fullscreen_opacity = 1.0;

      blur = {
        enabled = false;
      };

      shadow = {
        enabled = false;
      };
    };
  };
}
