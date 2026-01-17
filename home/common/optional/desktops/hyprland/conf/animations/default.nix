# Animation configuration selector
# Change the import to switch animation styles
{ ... }:
{
  imports = [
    ./standard.nix # Default ML4W animations
    # ./end4.nix     # End-4 style animations
    # ./dynamic.nix  # Dynamic animations
    # ./smooth.nix   # Smooth animations
    # ./disabled.nix # Disable animations (performance mode)
  ];
}
