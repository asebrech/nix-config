{ pkgs, ... }:
{
  imports = [
    # Hyprland window manager (ML4W-inspired structure)
    ./hyprland

    ########## Utilities ##########
    ./services/dunst.nix # Notification daemon
    ./waybar # Status bar
  ];

  home.packages = with pkgs; [
    pulseaudio # add pulse audio to the user path
    pavucontrol # gui for pulseaudio server and volume controls
    wl-clipboard # wayland copy and paste
    galculator # gtk based calculator
    foot # lightweight wayland terminal
  ];
}
