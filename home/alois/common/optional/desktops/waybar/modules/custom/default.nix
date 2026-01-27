# Custom Waybar modules index
# Adapted from mechabar: modules/custom/*.jsonc
#
# Structure (matching mechabar):
#   dividers.nix      - Powerline separator characters
#   user.nix          - User group (trigger + username)
#   distro.nix        - Distro icon
#   power-menu.nix    - Power menu button
#   system-update.nix - System update indicator
#   notifications.nix - SwayNC notification center
let
  dividers = import ./dividers.nix;
  user = import ./user.nix;
  distro = import ./distro.nix;
  powerMenu = import ./power-menu.nix;
  systemUpdate = import ./system-update.nix;
  notifications = import ./notifications.nix;
in
dividers // user // distro // powerMenu // systemUpdate // notifications
