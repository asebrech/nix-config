# Mechabar CSS styles with Stylix color integration
# Adapted from mechabar: style.css, styles/*.css
# Stylix injects @define-color for base00-base0F
#
# Structure (matching mechabar):
#   base.nix          - Core waybar styles (from style.css)
#   fonts.nix         - Font configuration (from styles/fonts.css)
#   modules-left.nix  - Left bar modules (from styles/modules-left.css)
#   modules-center.nix - Center bar modules (from styles/modules-center.css)
#   modules-right.nix - Right bar modules (from styles/modules-right.css)
#   states.nix        - Module state styles (from styles/states.css)
let
  base = import ./base.nix;
  fonts = import ./fonts.nix;
  modulesLeft = import ./modules-left.nix;
  modulesCenter = import ./modules-center.nix;
  modulesRight = import ./modules-right.nix;
  states = import ./states.nix;
in
''
  /* Mechabar CSS - Colors from Stylix base16 scheme */
  /* Structure adapted from github.com/sejjy/mechabar */

  ${base}
  ${fonts}
  ${modulesLeft}
  ${modulesCenter}
  ${modulesRight}
  ${states}
''
