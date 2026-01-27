# Environment variables configuration selector
# ML4W default uses standard environment variables
# Change the import to switch environment configurations
{ ... }:
{
  imports = [
    ./standard.nix # Default (Standard Wayland environment variables)
    # ./nvidia.nix   # NVIDIA GPU optimizations
    # ./kvm.nix      # KVM/VM environment
  ];
}
