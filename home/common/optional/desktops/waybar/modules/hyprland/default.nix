# Hyprland modules index
# Adapted from mechabar: modules/hyprland/*.jsonc
#
# Structure:
#   workspaces.nix  - Workspace switcher
#   window.nix      - Window title display
#   windowcount.nix - Window count indicator
let
  workspaces = import ./workspaces.nix;
  window = import ./window.nix;
  windowcount = import ./windowcount.nix;
in
workspaces // window // windowcount
