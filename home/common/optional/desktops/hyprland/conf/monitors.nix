# Monitor configuration from host spec
# Reads monitor spec from nix-config/hosts/<host>.nix
# Dynamic configuration managed by hyprdynamicmonitors
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Source dynamic monitor configuration from hyprdynamicmonitors
    # This will be automatically updated when monitors change
    source = [ "~/.config/hypr/monitors.conf" ];

    # NOTE: Static fallback monitor configuration is disabled when using hyprdynamicmonitors
    # to avoid conflicts. The static config would override the dynamic mirror settings.
    # Fallback static monitor configuration (used if hyprdynamicmonitors is not running)
    # Parse the monitor spec defined in nix-config/hosts/<host>.nix
    # monitor = (
    #   map (
    #     m:
    #     "${m.name},${
    #       if m.enabled then
    #         "${toString m.width}x${toString m.height}@${toString m.refreshRate}"
    #         + ",${toString m.x}x${toString m.y},${toString m.scale}"
    #         + ",transform,${toString m.transform}"
    #         + ",vrr,${toString m.vrr}"
    #       else
    #         "disable"
    #     }"
    #   ) osConfig.monitors
    # );
  };
}
