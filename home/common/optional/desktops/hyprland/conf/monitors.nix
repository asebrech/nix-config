# Monitor configuration
# Dynamic configuration managed by hyprdynamicmonitors
{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Source dynamic monitor configuration from hyprdynamicmonitors
    # The file is created/managed by the hyprdynamicmonitors service
    # Using absolute path to avoid glob expansion issues
    source = [ "${config.home.homeDirectory}/.config/hypr/monitors.conf" ];

    # No static monitor configuration - let hyprdynamicmonitors handle everything
    # The hyprdynamicmonitors-prepare.service ensures the file exists before Hyprland starts
  };
}
