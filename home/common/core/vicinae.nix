{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:
{
  # Only enable on Linux with Wayland
  config = lib.mkIf (pkgs.stdenv.isLinux && osConfig.hostSpec.useWayland) {
    # Let Stylix handle theming automatically
    stylix.targets.vicinae.enable = true;

    services.vicinae = {
      enable = true;
      extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        hypr-keybinds
        nix
      ];
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
      };
    };
  };
}
