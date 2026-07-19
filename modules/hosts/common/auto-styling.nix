# Stylix theming, enabled per-host via hostSpec.isAutoStyled.
# Adapted from EmergentMind's auto-styling module (nixos-only, our fonts).
{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
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
      image =
        if config.hostSpec.wallpaper != null then
          config.hostSpec.wallpaper
        else
          # Default fallback wallpaper
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-simple-dark-gray.png";
            hash = "sha256-JaLHdBxwrphKVherDVe5fgh+3zqUtpcwuNbjwrBlAok=";
          };
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
