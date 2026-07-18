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
          "office.nix"
          "zed.nix"
          "zellij.nix"
          "claude-code.nix"

          "sops.nix"
        ])
    )
  );

  # Never auto-suspend on AC power on this host: suspending while docked
  # breaks the external display until the lid is opened (Asahi DCP resume
  # issue, https://github.com/AsahiLinux/linux/issues/430). Battery
  # behavior keeps the COSMIC default.
  wayland.desktopManager.cosmic.idle = {
    suspend_on_ac_time = {
      __type = "optional";
      value = null;
    };
  };
}
