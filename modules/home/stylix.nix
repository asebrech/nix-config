{
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.hostSpec.isAutoStyled {
    stylix = {
      enableReleaseChecks = false; # Using master branch for vicinae support
      # Disable GNOME shell theming - not needed for Hyprland
      targets.gnome.enable = false;
    };
  };
}
