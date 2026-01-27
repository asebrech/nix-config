#
# SwayNotificationCenter
# A notification daemon for Sway/Wayland with a notification center panel
# https://github.com/ErikReider/SwayNotificationCenter
#
# Config adapted from: https://github.com/cebem1nt/dotfiles
# Colors and fonts from Stylix
#
{
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors.withHashtag;
  font = config.stylix.fonts.monospace.name;
in
{
  # Disable Stylix CSS for swaync - we provide our own
  stylix.targets.swaync.enable = false;

  home.packages = lib.attrValues {
    inherit (pkgs) libnotify;
  };

  services.swaync = {
    enable = true;
    settings = import ./config.nix;
    style = import ./style.nix { inherit colors font; };
  };
}
