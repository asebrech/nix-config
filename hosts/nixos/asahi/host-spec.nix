{ pkgs, ... }:
{
  hostSpec = {
    hostName = "asahi";
    isAutoStyled = true; # stylix theming
    theme = "catppuccin-mocha";
    # The official NixOS catppuccin-mocha wallpaper, matching the theme.
    wallpaper = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nixos-wallpaper-catppuccin-mocha.png";
      hash = "sha256-fmKFYw2gYAYFjOv4lr8IkXPtZfE1+88yKQ4vjEcax1s=";
    };
  };
}
