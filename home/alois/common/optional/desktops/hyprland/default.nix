# Hyprland window manager configuration
# ML4W-inspired modular structure adapted for NixOS
# Theming handled by Stylix
{ pkgs, ... }:
{
  imports = [
    # Core Hyprland configuration
    ./hyprland.nix

    # Configuration modules (import selectors)
    ./conf/animations # Animation styles
    ./conf/decorations # Window decorations
    ./conf/windows.nix # Window layout and gaps
    ./conf/keybindings.nix # Keybindings
    ./conf/monitors.nix # Monitor configuration
    ./conf/environments # Environment variables
    ./conf/windowrules.nix # Window rules
    ./conf/autostart.nix # Autostart applications
    ./conf/keyboard.nix # Keyboard and input settings
    ./conf/cursor.nix # Cursor configuration
    ./conf/misc.nix # Miscellaneous settings

    # Hyprland utilities
    ./hypridle.nix # Idle management
    ./hyprlock # Lock screen (11 styles available)
  ];

  # Hyprland-specific packages
  home.packages = with pkgs; [
    swww # wallpaper daemon (used in autostart)
    hyprpicker # color picker (used in keybindings)
  ];
}
