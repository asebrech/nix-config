{ pkgs, ... }:
{
  hostSpec = {
    hostName = "asahi";
    isAutoStyled = true; # stylix theming
    theme = "catppuccin-mocha";
    # Official NixOS "catppuccin-mocha" wallpaper (nixos-artwork): the
    # stylised valley/lake scene with the snowflake, in the mocha palette.
    # Only the desktop background; the theme stays catppuccin-mocha (stylix
    # keeps base16Scheme, noctalia keeps useWallpaperColors = false).
    wallpaper = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nixos-wallpaper-catppuccin-mocha.png";
      hash = "sha256-fmKFYw2gYAYFjOv4lr8IkXPtZfE1+88yKQ4vjEcax1s=";
    };
  };
}
