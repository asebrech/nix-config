# Vesktop: a native Discord client. The official Discord build is x86_64
# only (no aarch64), whereas Vesktop runs natively on aarch64, has working
# Wayland screenshare (via the PipeWire portal) and ships Vencord.
#
# Settings (settings.json) are declared, so the in-app settings become
# read-only — change them here.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "stable";
      arRPC = true; # Rich Presence (game activity)
      tray = true;
      minimizeToTray = true;
    };
  };

  # The first-run setup wizard is gated on the "firstLaunch" key existing in
  # Vesktop's *state* store (state.json), which the module doesn't manage and
  # which also holds mutable runtime state (window bounds, screenshare
  # quality). Seed it once, writably, so the wizard is skipped while Vesktop
  # keeps ownership of its state.
  home.activation.vesktopSkipSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    state="${config.xdg.configHome}/vesktop/state.json"
    if [ ! -e "$state" ]; then
      $DRY_RUN_CMD mkdir -p "$(dirname "$state")"
      $DRY_RUN_CMD install -m600 ${
        pkgs.writeText "vesktop-state.json" (builtins.toJSON { firstLaunch = false; })
      } "$state"
    fi
  '';
}
