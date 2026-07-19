{ lib, pkgs, ... }:
{
  home.packages = lib.attrValues {
    inherit (pkgs)
      libreoffice # office suite (docx, xlsx, odt...)
      papers # GNOME PDF viewer (GTK4, successor to evince)
      ;
  };

  # Papers as the default PDF viewer (was Brave)
  xdg.mimeApps.defaultApplications."application/pdf" = [ "org.gnome.Papers.desktop" ];
}
