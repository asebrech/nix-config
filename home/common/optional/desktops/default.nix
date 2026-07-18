{ pkgs, ... }:
{
  imports = [
    ./playerctl.nix # Media player control
  ];

  home.packages = with pkgs; [
    pulseaudio # add pulse audio to the user path
    pavucontrol # gui for pulseaudio server and volume controls
    wl-clipboard # wayland copy and paste
    galculator # gtk based calculator
  ];
}
