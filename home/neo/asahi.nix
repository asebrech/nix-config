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
          "comms"
          "media"
          "reverse-engineering.nix"
          "tmux"
          "opencode.nix"
          "claude-code.nix"

          "sops.nix"
        ])
    )
  );
}
