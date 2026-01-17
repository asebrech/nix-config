# Hyprpaper - Wallpaper engine
# Integrated with Stylix for automatic wallpaper management
{ pkgs, ... }:
{
  # Using swww for animated wallpaper support
  # Stylix will automatically set the wallpaper via stylix.image
  home.packages = with pkgs; [
    swww
  ];
}
