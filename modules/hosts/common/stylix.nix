{
  pkgs,
  inputs,
  config,
  lib,
  isDarwin,
  ...
}:
let
  platform = if isDarwin then "darwin" else "nixos";
  platformModules = "${platform}Modules";
in
{
  imports = [
    inputs.stylix.${platformModules}.stylix
  ];

  config = lib.mkIf config.hostSpec.isAutoStyled {
    stylix = {
      enable = true;
      autoEnable = true; # Auto-enable styling for all supported targets
      polarity = "dark";

      # Wallpaper - can be overridden per-host via hostSpec.wallpaper
      image = lib.mkDefault (
        if config.hostSpec ? wallpaper && config.hostSpec.wallpaper != "" then
          config.hostSpec.wallpaper
        else
          # Default fallback wallpaper
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-simple-dark-gray.png";
            hash = "sha256-JaLHdBxwrphKVherDVe5fgh+3zqUtpcwuNbjwrBlAok=";
          }
      );

      # Base16 color scheme - Gruvbox Dark Hard (matches Omarchy aesthetic)
      # Can be overridden per-host via hostSpec.theme
      base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

      # Opacity settings
      opacity = {
        applications = 1.0;
        terminal = 0.95;
        desktop = 1.0;
        popups = 0.9;
      };

      # Cursor theme
      cursor = {
        name = "Adwaita";
        size = 24;
        package = pkgs.adwaita-icon-theme;
      };

      # Font configuration - matching your JetBrainsMono Nerd Font setup
      fonts = rec {
        monospace = {
          name = "JetBrainsMono Nerd Font";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };
        sansSerif = monospace;
        serif = monospace;
        emoji = {
          package = pkgs.nerd-fonts.symbols-only;
          name = "Symbols Nerd Font";
        };
        sizes = {
          terminal = 12;
          desktop = 12;
          popups = 11;
          applications = 12;
        };
      };
    };
  };
}
