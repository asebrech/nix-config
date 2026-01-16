{ pkgs, ... }:
{
  imports = [
    # Packages with custom configs go here

    ./hyprland

    ########## Utilities ##########
    ./services/dunst.nix # Notification daemon
    ./waybar.nix # infobar
  ];
  home.packages = [
    pkgs.pulseaudio # add pulse audio to the user path
    pkgs.pavucontrol # gui for pulseaudio server and volume controls
    pkgs.wl-clipboard # wayland copy and paste
    pkgs.galculator # gtk based calculator
    pkgs.unstable.grimblast # screenshot tool
    pkgs.foot # lightweight wayland terminal without GPU acceleration
  ];
}
