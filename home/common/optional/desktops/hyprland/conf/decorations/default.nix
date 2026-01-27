# Decoration configuration selector
# ML4W default uses glass style (Rounding All Blur No Shadows)
# Change the import to switch decoration styles
{ ... }:
{
  imports = [
    ./glass.nix # Default (Glass/transparent style)
    # ./blur.nix
    # ./rounding.nix
    # ./rounding-more-blur.nix
    # ./rounding-all-blur.nix
    # ./rounding-all-blur-no-shadows.nix
    # ./no-blur.nix
    # ./no-rounding.nix
    # ./no-rounding-more-blur.nix
    # ./gamemode.nix
  ];
}
