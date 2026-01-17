# Window rules configuration selector
# Change the import to switch window rules
{ ... }:
{
  imports = [
    ./standard.nix # Default ML4W window rules
    # ./custom.nix   # User-defined rules
  ];
}
