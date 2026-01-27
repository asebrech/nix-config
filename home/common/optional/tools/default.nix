{ lib, pkgs, ... }:
{
  home.packages = lib.attrValues {
    inherit (pkgs.unstable)
      grimblast # screenshot tool
      ;
  };
}
