{ lib, pkgs, ... }:
{
  home.packages = lib.attrValues {
    inherit (pkgs)
      libreoffice # office suite (docx, xlsx, odt...)
      ;
  };
}
