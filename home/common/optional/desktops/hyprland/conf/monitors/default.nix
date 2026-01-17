# Monitor configuration selector
# Change the import to switch monitor configurations
{ ... }:
{
  imports = [
    ./standard.nix # Auto-detect from host configuration
    # ./laptop.nix   # Single laptop screen
    # ./desktop.nix  # Multi-monitor desktop
    # ./gamemode.nix # Gaming-optimized refresh rates
  ];
}
