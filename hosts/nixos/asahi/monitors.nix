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
      scale = 1.5; # Makes 4K comfortable (effective 2560x1440)
      primary = true;
      x = 0;
      y = 0;
    }
  ];
}
