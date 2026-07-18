# Zed editor, stock configuration
{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    # Zed moves fast; track unstable like the other frequently-updated apps
    package = pkgs.unstable.zed-editor;
  };
}
