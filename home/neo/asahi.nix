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
          "desktops"
          "media"
          "office.nix"
          "zed.nix"
          "zellij.nix"
          "claude-code.nix"

          "sops.nix"
        ])
    )
  );

  # Only auto-suspend on battery on this host: suspending while docked
  # breaks the external display until the lid is opened (Asahi DCP resume
  # issue, https://github.com/AsahiLinux/linux/issues/430).
  programs.noctalia-shell.settings.idle.suspendCommand =
    "sh -c 'grep -q 1 /sys/class/power_supply/*/online 2>/dev/null || systemctl suspend'";
}
