#
# This file defines overlays/custom modifications to upstream packages
#

{ inputs, lib, ... }:

let
  overlays = {
    # Adds my custom packages
    additions =
      final: prev:
      (prev.lib.packagesFromDirectoryRecursive {
        callPackage = prev.lib.callPackageWith final;
        directory = ../pkgs;
      });

    linuxModifications = _final: prev: lib.optionalAttrs prev.stdenv.isLinux { };

    modifications = _final: _prev: {
      # example = prev.example.overrideAttrs (previousAttrs: let ... in {
      # ...
      # });
    };

    unstable-packages = final: _prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (final.stdenv.hostPlatform) system;
        config.allowUnfree = true;
      };
    };
  };
in
{
  default =
    final: prev:
    lib.attrNames overlays
    |> map (name: (overlays.${name} final prev))
    # nixfmt hack
    |> lib.mergeAttrsList;
}
