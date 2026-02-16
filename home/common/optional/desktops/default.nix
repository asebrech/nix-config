{ pkgs, ... }:
{
  imports = [
    # Hyprland window manager (ML4W-inspired structure)
    ./hyprland

    ########## Utilities ##########
    ./services/swaync # SwayNotificationCenter (ML4W-style modular structure)
    ./playerctl.nix # Media player control
    ./vicinae.nix # Vicinae command palette
    ./waybar # Status bar
    # Note: hyprdynamicmonitors is imported per-host (see home/asahi.nix)
  ];

  home.packages = with pkgs; [
    pulseaudio # add pulse audio to the user path
    pavucontrol # gui for pulseaudio server and volume controls
    wl-clipboard # wayland copy and paste
    galculator # gtk based calculator
  ];
}
