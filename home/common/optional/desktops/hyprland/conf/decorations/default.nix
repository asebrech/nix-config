# Decoration configuration selector
# Change the import to switch decoration styles
{ ... }:
{
  imports = [
    ./standard.nix # Default ML4W decorations
    # ./blur.nix     # Enhanced blur effects
    # ./minimal.nix  # Minimal decorations
    # ./gamemode.nix # Gaming optimizations (reduced effects)
  ];
}
