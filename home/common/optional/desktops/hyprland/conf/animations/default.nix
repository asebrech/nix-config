# Animation configuration selector
# ML4W default uses end4 animations
# Change the import to switch animation styles
{ ... }:
{
  imports = [
    ./animations-end4.nix # Default (End-4 style)
    # ./animations-classic.nix
    # ./animations-dynamic.nix
    # ./animations-fast.nix
    # ./animations-high.nix
    # ./animations-moving.nix
    # ./animations-smooth.nix
    # ./disabled.nix # Disable animations
  ];
}
