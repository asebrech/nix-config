# Hyprlock styles selector
# Choose between 11 different lock screen styles
# All styles adapted to use Stylix colors and user avatar
{
  # Available styles:
  # style-0: ML4W-inspired (original) - Clock top right, profile centered
  # style-1: Left-aligned layout with song details
  # style-2: Centered with large clock outline
  # style-3: Centered layout with blur and song details
  # style-4: Centered with profile and name
  # style-5: Accent time with emoji logo and song details
  # style-6: macOS-inspired with Touch ID style and song details
  # style-7: Split time display (hour/minute) with song details
  # style-8: Large split time with accent color and song details (with Spotify status icons)
  # style-9: Clean centered with profile and song details
  # style-10: Simple centered with power controls (reboot/shutdown/suspend)

  # To change style, modify the import below to use a different style file
  imports = [
    ./style-3.nix # Default: ML4W-inspired style
  ];
}
