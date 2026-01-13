{
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.hostSpec.isAutoStyled {
    stylix = {
      # Enable user-specific Stylix targets
      targets = {
        # Terminal emulators
        alacritty.enable = true;
        kitty.enable = lib.mkDefault false; # Disable if not used

        # Rofi
        rofi.enable = true;

        # Hyprland (inherits from system but can be overridden here)
        hyprland.enable = true;

        # Waybar
        waybar.enable = true;

        # Notifications
        dunst.enable = true;

        # GTK
        gtk.enable = true;
      };
    };
  };
}
