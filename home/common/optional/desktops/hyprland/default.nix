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
    ./hyprpaper.nix # Wallpaper engine
    ./autostart.nix # Autostart applications
    ./xdph.nix # XDG Desktop Portal
  ];

  # Additional packages for Hyprland
  home.packages = with pkgs; [
    # Screenshot and color picker
    unstable.grimblast
    hyprpicker

    # Clipboard manager
    copyq

    # Brightness control
    brightnessctl

    # Notification daemon (managed via systemd)
    # dunst is configured in ../services/dunst.nix

    # Audio control
    pulseaudio # for pactl
    pavucontrol

    # Wayland utilities
    wl-clipboard

    # File manager
    xfce.thunar

    # Calculator
    galculator

    # Player control
    playerctl

    # Terminal
    foot
  ];
}
