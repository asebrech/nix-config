{ config, ... }:
let
  scaling = builtins.fromJSON config.hostSpec.scaling;
in
{
  #
  # ========== Host-specific Monitor Spec ==========
  #
  # This uses the nix-config/modules/common/monitors.nix module
  # If on hyprland, use `hyprctl monitors` to get monitor info.
  # https://wiki.hyprland.org/Configuring/Monitors/

  monitors = [
    {
      name = "eDP-1";
      width = 3456;
      height = 2160;
      refreshRate = 60;
      scale = scaling; # e.g. 1.5
      primary = true;
      x = 0;
      y = 0;
    }
  ];
}
