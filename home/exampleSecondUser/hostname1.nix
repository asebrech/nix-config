{ lib, pkgs, ... }:
{
  imports = (
    map lib.custom.relativeToRoot (
      [
        #
        # ========== Required Configs ==========
        #
        "home/common/core"
        "home/common/core/nixos.nix"

        "home/exampleSecondUser/common"
      ]
      ++
        #
        # ========== Host-specific Optional Configs ==========
        #
        (map (f: "home/common/optional/${f}") [
          # Add optional configs here as needed
        ])
    )
  );

  # FIXME(starter): you can also add packages that don't require any declarative configuration below
  home.packages = builtins.attrValues {
    inherit (pkgs)
      vlc # media player
      ;
  };
}
