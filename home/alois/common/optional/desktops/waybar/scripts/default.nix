# Mechabar scripts - nixified and installed to ~/.config/waybar/scripts
# Adapted from https://github.com/sejjy/mechabar/tree/main/scripts
# Split into individual files matching mechabar structure
{ pkgs, ... }:
let
  volumeScript = import ./volume.nix { inherit pkgs; };
  backlightScript = import ./backlight.nix { inherit pkgs; };
  networkScript = import ./network.nix { inherit pkgs; };
  bluetoothScript = import ./bluetooth.nix { inherit pkgs; };
  powerMenuScript = import ./power-menu.nix { inherit pkgs; };
  systemUpdateScript = import ./system-update.nix { inherit pkgs; };
in
{
  # Create the scripts directory and symlink scripts
  home.file = {
    ".config/waybar/scripts/volume.sh" = {
      source = volumeScript;
      executable = true;
    };
    ".config/waybar/scripts/backlight.sh" = {
      source = backlightScript;
      executable = true;
    };
    ".config/waybar/scripts/network.sh" = {
      source = networkScript;
      executable = true;
    };
    ".config/waybar/scripts/bluetooth.sh" = {
      source = bluetoothScript;
      executable = true;
    };
    ".config/waybar/scripts/power-menu.sh" = {
      source = powerMenuScript;
      executable = true;
    };
    ".config/waybar/scripts/system-update.sh" = {
      source = systemUpdateScript;
      executable = true;
    };
  };
}
