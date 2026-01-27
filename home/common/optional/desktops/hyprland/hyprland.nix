# Core Hyprland configuration
# Note: All settings are imported via modules in default.nix
{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
  };
}
