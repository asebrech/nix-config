# Zed editor, stock configuration
{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    # Zed moves fast; track unstable like the other frequently-updated apps
    package = pkgs.unstable.zed-editor;
  };

  # Zed as the default text editor
  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "dev.zed.Zed.desktop" ];
    "text/markdown" = [ "dev.zed.Zed.desktop" ];
  };
}
