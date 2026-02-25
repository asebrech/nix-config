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

    # Pin opencode.nvim ahead of nixpkgs — fixes multiple-instance bug and
    # migrates to the new `server` API (replaces broken `provider` system).
    vimPlugins = prev.vimPlugins // {
      opencode-nvim = prev.vimUtils.buildVimPlugin {
        pname = "opencode.nvim";
        version = "2026-02-24";
        src = prev.fetchFromGitHub {
          owner = "NickvanDyke";
          repo = "opencode.nvim";
          rev = "8992d0c6168ad28f91b03f7dcdb98b5ebb675c32";
          sha256 = "0hp0skxx53ynjnyqfld480ai2922a3716k8fnnz9f0wrk8qmw8w2";
        };
      };
    };
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
