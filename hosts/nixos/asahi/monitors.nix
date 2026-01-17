{ ... }:
{
  #
  # ========== Host-specific Monitor Spec ==========
  #
  # This uses the nix-config/modules/common/monitors.nix module
  # If on hyprland, use `hyprctl monitors` to get monitor info.
  # https://wiki.hyprland.org/Configuring/Monitors/

  monitors = [
    {
      name = "Virtual-1";
      width = 3840;
      height = 2160;
      refreshRate = 60;
      scale = 2.0; # Makes 4K feel like 1080p but crisp (effective 1920x1080)
      primary = true;
      x = 0;
      y = 0;
    }
  ];
}
