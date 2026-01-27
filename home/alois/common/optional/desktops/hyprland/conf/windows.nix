# Window layout configuration
# Adapted from ML4W dotfiles: default.conf
# https://github.com/mylinuxforwork/dotfiles
#
# Values halved for 2x monitor scaling (5→10, 10→20 visual)
# Colors handled by Stylix
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 1;
      layout = "dwindle";
      resize_on_border = true;
    };

    # Dwindle layout settings - controls window tiling behavior
    dwindle = {
      pseudotile = true; # Enable pseudotiling
      preserve_split = true; # Keep split direction
      force_split = 2; # 0=split follows mouse, 1=always left/top, 2=always right/bottom
    };
  };
}
