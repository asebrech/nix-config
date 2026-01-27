# NVIDIA GPU optimizations
# Adapted from ML4W dotfiles: nvidia.conf
# https://github.com/mylinuxforwork/dotfiles
# Note: Includes standard.nix defaults plus NVIDIA-specific settings
{ ... }:
{
  imports = [ ./standard.nix ];

  wayland.windowManager.hyprland.settings = {
    # NVIDIA specific environment variables
    # https://wiki.hyprland.org/Nvidia/
    env = [
      "GBM_BACKEND,nvidia-drm"
      "LIBVA_DRIVER_NAME,nvidia"
      "SDL_VIDEODRIVER,wayland"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "__NV_PRIME_RENDER_OFFLOAD,1"
      "__VK_LAYER_NV_optimus,NVIDIA_only"

      # For VM and possibly NVIDIA
      "WLR_NO_HARDWARE_CURSORS,1"
      "WLR_RENDERER_ALLOW_SOFTWARE,1"

      # NVIDIA Firefox hardware acceleration
      "MOZ_DISABLE_RDD_SANDBOX,1"
      "EGL_PLATFORM,wayland"
    ];

    cursor = {
      no_hardware_cursors = true;
    };
  };
}
