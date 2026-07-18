#
# This file defines overlays/custom modifications to upstream packages
#

{ inputs, ... }:

let
  # Apple Silicon support overlay (for Asahi Linux)
  asahi-overlay = import ../hosts/asahi/apple-silicon-support/packages/overlay.nix;

  # Add in custom packages from this config
  additions =
    final: prev:
    (prev.lib.packagesFromDirectoryRecursive {
      callPackage = prev.lib.callPackageWith final;
      directory = ../pkgs/common;
    });

  linuxModifications = final: prev: prev.lib.mkIf final.stdenv.isLinux { };

  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: let ... in {
    # ...
    # });
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
      #overlays = [
      #];
    };
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
      #overlays = [
      #];
    };
  };

in
{
  default =
    final: prev:

    (asahi-overlay final prev)
    // (additions final prev)
    // (modifications final prev)
    // (linuxModifications final prev)
    // (stable-packages final prev)
    // (unstable-packages final prev);
}
