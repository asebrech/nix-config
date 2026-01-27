# Extras modules index
# Adapted from mechabar: modules/extras/*.jsonc
#
# Structure:
#   taskbar.nix    - WLR taskbar
#   tray.nix       - System tray
#   wireplumber.nix - Wireplumber audio control
let
  taskbar = import ./taskbar.nix;
  tray = import ./tray.nix;
  wireplumber = import ./wireplumber.nix;
in
taskbar // tray // wireplumber
