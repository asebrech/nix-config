# Core Hyprland configuration
# This file combines all configuration modules
{
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      # Input settings
      input = (import ./conf/input.nix { inherit lib; }).wayland.windowManager.hyprland.settings.input;

      # Misc settings
      misc = (import ./conf/misc.nix { inherit lib; }).wayland.windowManager.hyprland.settings.misc;

      # Cursor settings
      cursor = {
        no_hardware_cursors = false;
      };
    };
  };
}
