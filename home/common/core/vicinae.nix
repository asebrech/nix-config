{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:
let
  # Map Stylix base16 theme names to Vicinae theme names
  stylixToVicinae = {
    "tokyo-night-dark" = "Tokyo Night";
    "gruvbox-dark-hard" = "Gruvbox Dark";
    "catppuccin-mocha" = "Catppuccin Mocha";
    # Add more mappings as needed
  };

  # Get the Vicinae theme name from Stylix theme, fallback to Tokyo Night
  vicinaeTheme = stylixToVicinae.${osConfig.hostSpec.theme} or "Tokyo Night";
in
{
  # Only enable on Linux with Wayland
  config = lib.mkIf (pkgs.stdenv.isLinux && osConfig.hostSpec.useWayland) {
    services.vicinae = {
      enable = true;
      extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        hypr-keybinds
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
        font = {
          normal = {
            size = 12;
            normal = osConfig.stylix.fonts.monospace.name;
          };
        };
        theme = {
          dark = {
            name = vicinaeTheme;
            icon_theme = "default";
          };
        };
        launcher_window = {
          opacity = 0.95; # Match terminal opacity
        };
      };
    };
  };
}
