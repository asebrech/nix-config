{ ... }:
{
  # Let Stylix handle all theming (colors, wallpaper, fonts, input-field)
  stylix.targets.hyprlock = {
    enable = true;
    useWallpaper = true;
  };

  programs.hyprlock = {
    enable = true;
    importantPrefixes = [
      "$"
      "monitor"
      "size"
      "source"
    ];
    settings = {
      general = {
        ignore_empty_input = true;
      };

      animations = {
        enabled = false;
      };

      auth = {
        "fingerprint:enabled" = true;
      };
    };
  };
}
