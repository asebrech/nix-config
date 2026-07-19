# Custom functions added here are available via `lib.custom.foo` by passing `lib` into
# the expression parameters.
{ lib, ... }:
{
  # use path relative to the root of the project
  relativeToRoot = lib.path.append ../.;

  # return a list of all .nix files (except default.nix) and directories in path
  scanPaths =
    path:
    lib.map (f: (path + "/${f}")) (
      lib.attrNames (
        lib.attrsets.filterAttrs (
          path: _type:
          (_type == "directory") # include directories
          || (
            (path != "default.nix") # ignore default.nix
            && (lib.strings.hasSuffix ".nix" path) # include .nix files
          )
        ) (builtins.readDir path)
      )
    );

  checks = {
    # Pre-commit hook set consumed by checks/default.nix.
    # Upstream gets this from its private introdus lib; we define it locally.
    mkPreCommitHooks = pkgs: formatter: {
      # ========== General ==========
      check-added-large-files = {
        enable = true;
        excludes = [
          "\\.png"
          "\\.jpg"
          "hosts/nixos/asahi/firmware/firmware\\.cpio"
        ];
      };
      check-case-conflicts.enable = true;
      check-executables-have-shebangs.enable = true;
      check-merge-conflicts.enable = true;
      detect-private-keys.enable = true;
      fix-byte-order-marker.enable = true;
      mixed-line-endings.enable = true;
      trim-trailing-whitespace.enable = true;
      end-of-file-fixer.enable = true;

      # ========== nix ==========
      nixfmt-rfc-style = {
        enable = true;
        package = formatter;
        # Vendored upstream code (synced verbatim from nixos-apple-silicon)
        excludes = [ "hosts/nixos/asahi/apple-silicon-support/" ];
      };
      deadnix = {
        enable = true;
        # Vendored upstream code (synced verbatim from nixos-apple-silicon)
        excludes = [ "hosts/nixos/asahi/apple-silicon-support/" ];
        settings = {
          noLambdaArg = true;
        };
      };
      unwanted-builtins = {
        enable = true;
        name = "unwanted-builtins";
        description = "prefer lib over builtins in nix files";
        entry = "${
          pkgs.writeShellApplication {
            name = "unwanted-builtins";
            runtimeInputs = [ pkgs.ripgrep ];
            text = lib.readFile ../checks/unwanted-builtins.sh;
          }
        }/bin/unwanted-builtins";
        files = "\\.nix$";
        pass_filenames = false;
      };

      # ========== shellscripts ==========
      shfmt.enable = true;
      shellcheck = {
        enable = true;
        excludes = [ "\\.envrc" ];
      };
    };
  };
}
