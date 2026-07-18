{ lib, ... }:
{
  imports = (
    map lib.custom.relativeToRoot (
      [
        #
        # ========== Required Configs ==========
        #
        "home/common/core"
        "home/neo/common"
      ]
      ++
        #
        # ========== Host-specific Optional Configs ==========
        #
        (map (f: "home/common/optional/${f}") [
          "browsers"
          "cosmic.nix"
          "media"
          "zed.nix"
          "zellij.nix"
          "claude-code.nix"

          "sops.nix"
        ])
    )
  );
}
