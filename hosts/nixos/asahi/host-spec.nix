{ ... }:
{
  hostSpec = {
    hostName = "asahi";
    isAutoStyled = true; # stylix theming
    # The wallpaper follows the theme automatically (see auto-styling.nix);
    # set hostSpec.wallpaper to override it with a specific image.
    theme = "catppuccin-mocha";
  };
}
