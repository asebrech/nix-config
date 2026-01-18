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
    ./conf/windows # Window layout and gaps
    ./conf/keybindings # Keybindings
    ./conf/monitors # Monitor configuration
    ./conf/environments # Environment variables
    ./conf/windowrules # Window rules

    # Hyprland utilities
    ./hypridle.nix # Idle management
    ./hyprlock.nix # Lock screen
    ./autostart.nix # Autostart applications
  ];

  # Hyprland-specific packages
  home.packages = with pkgs; [
    swww # wallpaper daemon (used in autostart)
    unstable.grimblast # screenshot tool (used in keybindings)
    hyprpicker # color picker (used in keybindings)
    xfce.thunar # file manager (used in keybindings)
    copyq # clipboard manager (used in autostart)
    brightnessctl # brightness control (used in keybindings)
    playerctl # player control (used in keybindings)
  ];
}
