# Environment variables configuration selector
# Change the import to switch environment configurations
{ ... }:
{
  imports = [
    ./standard.nix # Standard ML4W environment variables
    # ./hidpi.nix    # HiDPI/4K scaling
    # ./nvidia.nix   # NVIDIA-specific variables
    # ./kvm.nix      # VM environment
  ];
}
