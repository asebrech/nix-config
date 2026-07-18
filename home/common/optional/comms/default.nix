{ lib, pkgs, ... }:
{
  #imports = [ ./foo.nix ];

  home.packages = lib.attrValues {
    inherit (pkgs)

      signal-desktop
      # discord # Join EmergentMind's server at https://discord.gg/XTFg57xGxC
      ;
  };
}
