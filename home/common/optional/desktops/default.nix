{ ... }:
{
  imports = [
    # Hyprland window manager (ML4W-inspired structure)
    ./hyprland

    ########## Utilities ##########
    ./services/dunst.nix # Notification daemon
    ./waybar # Status bar
  ];

  # Note: Hyprland-specific packages are now managed in ./hyprland/default.nix
}
