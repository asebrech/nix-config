{ lib, pkgs, ... }:
{
  #imports = [ ./foo.nix ];

  home.packages = lib.attrValues {
    inherit (pkgs)
      obs-studio
      vlc
      ;
  };
}
