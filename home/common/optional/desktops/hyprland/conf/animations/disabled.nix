# Animations disabled (performance mode)
# Adapted from ML4W dotfiles: https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = false;
    };
  };
}
