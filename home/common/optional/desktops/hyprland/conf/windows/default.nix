# Window configuration selector
# Change the import to switch window styles
{ ... }:
{
  imports = [
    ./standard.nix # Default ML4W window settings
    # ./border-2.nix    # Alternative border styles
    # ./transparent.nix # Transparent windows
    # ./gamemode.nix    # Gaming window optimizations
  ];
}
