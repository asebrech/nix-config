# Standard monitor configuration from host
# Reads monitor spec from nix-config/hosts/<host>.nix
{ osConfig, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Parse the monitor spec defined in nix-config/hosts/<host>.nix
    monitor = (
      map (
        m:
        "${m.name},${
          if m.enabled then
            "${toString m.width}x${toString m.height}@${toString m.refreshRate}"
            + ",${toString m.x}x${toString m.y},1"
            + ",transform,${toString m.transform}"
            + ",vrr,${toString m.vrr}"
          else
            "disable"
        }"
      ) osConfig.monitors
    );
  };
}
