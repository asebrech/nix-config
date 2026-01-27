# KVM/VM environment optimizations
# Adapted from ML4W dotfiles: kvm.conf
# https://github.com/mylinuxforwork/dotfiles
# Note: Includes standard.nix defaults plus KVM-specific settings
{ ... }:
{
  imports = [ ./standard.nix ];

  wayland.windowManager.hyprland.settings = {
    # KVM/VM specific environment variables
    env = [
      "WLR_RENDERER_ALLOW_SOFTWARE,1"
    ];
  };
}
