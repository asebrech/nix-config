{ pkgs, ... }:
{
  hostSpec = {
    hostName = "asahi";
    isAutoStyled = true; # stylix theming
    theme = "catppuccin-mocha";
    # JWST "Cosmic Cliffs" (Carina Nebula, NIRCam) — NASA/ESA/CSA, public
    # domain. 3840px crop of the Wikimedia Commons featured picture. Only
    # the desktop background; the theme stays catppuccin-mocha (stylix
    # keeps base16Scheme, noctalia keeps useWallpaperColors = false).
    wallpaper = pkgs.fetchurl {
      name = "cosmic-cliffs-carina-nircam.jpg";
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/NASA%E2%80%99s_Webb_Reveals_Cosmic_Cliffs%2C_Glittering_Landscape_of_Star_Birth.jpg/3840px-NASA%E2%80%99s_Webb_Reveals_Cosmic_Cliffs%2C_Glittering_Landscape_of_Star_Birth.jpg";
      hash = "sha256-7IR1Uto8ENXD2r7w1wm4yXMFXOmQDFc3azMaEi0CefM=";
    };
  };
}
