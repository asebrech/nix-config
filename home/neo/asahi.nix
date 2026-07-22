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
          "discord.nix"

          "sops.nix"
        ])
    )
  );

  # No idle auto-suspend on this host: waking from suspend breaks the
  # displays until the lid is opened (Asahi DCP resume issue,
  # https://github.com/AsahiLinux/linux/issues/430). Closing the lid on
  # battery still suspends via logind; idle keeps screen-off and lock.
  # NOTE: idle.suspendCommand is not a replacement hook — noctalia runs
  # it *in addition to* its own unconditional systemctl suspend.
  programs.noctalia-shell.settings.idle.suspendTimeout = 0;
}
