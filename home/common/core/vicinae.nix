{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:
let
  # Map Stylix base16 theme names to Vicinae theme names (only when different)
  # Vicinae themes: https://github.com/vicinaehq/vicinae/tree/main/extra/themes
  # Base16 themes: https://github.com/tinted-theming/schemes/tree/main/base16
  stylixToVicinae = {
    # Gruvbox variants → simplified names
    "gruvbox-dark-hard" = "gruvbox-dark";
    "gruvbox-dark-medium" = "gruvbox-dark";
    "gruvbox-dark-pale" = "gruvbox-dark";
    "gruvbox-dark-soft" = "gruvbox-dark";
    "gruvbox-light-hard" = "gruvbox-light";
    "gruvbox-light-medium" = "gruvbox-light";
    "gruvbox-light-soft" = "gruvbox-light";
    "gruvbox-material-dark-hard" = "gruvbox-dark";
    "gruvbox-material-dark-medium" = "gruvbox-dark";
    "gruvbox-material-dark-soft" = "gruvbox-dark";
    "gruvbox-material-light-hard" = "gruvbox-light";
    "gruvbox-material-light-medium" = "gruvbox-light";
    "gruvbox-material-light-soft" = "gruvbox-light";

    # One Dark variants
    "onedark" = "one-dark";
    "onedark-dark" = "one-dark";

    # Tokyo Night variants
    "tokyo-night-dark" = "tokyo-night";
    "tokyo-night-light" = "tokyo-night";
    "tokyo-night-terminal-dark" = "tokyo-night";
    "tokyo-night-terminal-light" = "tokyo-night";
    "tokyo-night-terminal-storm" = "tokyo-night-storm";
    "tokyo-city-dark" = "tokyo-night";
    "tokyo-city-light" = "tokyo-night";
    "tokyo-city-terminal-dark" = "tokyo-night";
    "tokyo-city-terminal-light" = "tokyo-night";
  };

  # Get the Vicinae theme name from Stylix theme, use same name if not mapped
  vicinaeTheme = stylixToVicinae.${osConfig.hostSpec.theme} or osConfig.hostSpec.theme;
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
