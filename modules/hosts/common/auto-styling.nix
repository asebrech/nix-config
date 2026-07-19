# Stylix theming, enabled per-host via hostSpec.isAutoStyled.
# Adapted from EmergentMind's auto-styling module (nixos-only, our fonts).
{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  # nixos-artwork ships a wallpaper per catppuccin flavour, so the desktop
  # background follows hostSpec.theme automatically. Add an entry here to
  # give another theme its matching wallpaper; unmapped themes get the
  # plain nix fallback below.
  catppuccinWallpaper =
    flavor: hash:
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nixos-wallpaper-catppuccin-${flavor}.png";
      inherit hash;
    };
  themeWallpapers = {
    catppuccin-latte = catppuccinWallpaper "latte" "sha256-Y6WCwmHOLBStj1D9mcU2082y1fhAFHna01ajfUHxehk=";
    catppuccin-frappe = catppuccinWallpaper "frappe" "sha256-wtBffKK9rqSJo8+7Wo8OMruRlg091vdroyUZj5mDPfI=";
    catppuccin-macchiato = catppuccinWallpaper "macchiato" "sha256-SkXrLbHvBOItJ7+8vW+6iXV+2g0f8bUJf9KcCXYOZF0=";
    catppuccin-mocha = catppuccinWallpaper "mocha" "sha256-fmKFYw2gYAYFjOv4lr8IkXPtZfE1+88yKQ4vjEcax1s=";
  };
  fallbackWallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-simple-dark-gray.png";
    hash = "sha256-JaLHdBxwrphKVherDVe5fgh+3zqUtpcwuNbjwrBlAok=";
  };
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  config = lib.mkIf config.hostSpec.isAutoStyled {
    stylix = {
      enable = true;

      # Don't complain about version mismatch, since stylix updates slower than nixpkgs
      enableReleaseChecks = false;

      polarity = "dark";
      # hostSpec.wallpaper overrides; otherwise the wallpaper follows the theme
      image =
        if config.hostSpec.wallpaper != null then
          config.hostSpec.wallpaper
        else
          themeWallpapers.${config.hostSpec.theme} or fallbackWallpaper;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.hostSpec.theme}.yaml";

      opacity.popups = 0.8;

      cursor = {
        name = "Adwaita";
        size = 24;
        package = pkgs.adwaita-icon-theme;
      };

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
          terminal = 14;
          desktop = 14;
          popups = 12;
        };
      };
    };
  };
}
