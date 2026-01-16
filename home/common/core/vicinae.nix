{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  # Only enable on Linux with Wayland
  config = lib.mkIf (pkgs.stdenv.isLinux && osConfig.hostSpec.useWayland) {
    services.vicinae = {
      enable = false; # Temporarily disabled - will re-enable after Cachix is active
      systemd = {
        enable = true;
        autoStart = false; # Let Hyprland start it with exec-once
        environment = {
          USE_LAYER_SHELL = "1";
        };
      };
      settings = {
        close_on_focus_loss = true;
        pop_to_root_on_close = true;
        font = {
          normal = {
            size = 12;
            normal = "JetBrainsMono Nerd Font";
          };
        };
        launcher_window = {
          opacity = 0.95; # Match terminal opacity
        };
      };
    };
  };
}
