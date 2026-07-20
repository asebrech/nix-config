{ lib, pkgs, ... }:
{
  imports = [
    ./niri
    ./noctalia.nix
    ./vicinae.nix
  ];

  home.packages = lib.attrValues {
    inherit (pkgs)
      cliphist # clipboard history backend for the noctalia launcher
      pavucontrol # audio mixer, opened by the noctalia volume widget
      brightnessctl # backlight control fallback
      nautilus # graphical file manager (also the portal file chooser)
      ;
  };

  # Open folders in nautilus (e.g. a browser's "show in folder", xdg-open
  # on a directory). The niri module already ships nautilus for the portal
  # file chooser; this just makes it the launchable default too.
  xdg.mimeApps.defaultApplications."inode/directory" = [ "org.gnome.Nautilus.desktop" ];
}
