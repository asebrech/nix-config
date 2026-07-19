# noctalia-shell: bar, launcher, notifications, control center, lock screen,
# idle management, wallpaper and OSD for the niri session.
#
# Stock configuration: only the necessary deltas are declared below; every
# other setting keeps the noctalia default. Colors come from the stylix
# noctalia-shell target automatically (autoEnable).
#
# NOTE: because settings are declared, the in-app Settings panel is
# read-only; tweak there to preview, then persist changes here.
{
  inputs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      settingsVersion = 59;

      # Launcher opens terminal apps in ghostty
      appLauncher.terminalCommand = "ghostty -e";

      # Weather/calendar location
      location.name = "Paris";

      # Screen off after 10min, lock after 11min, suspend after 30min
      # (the built-in noctalia lock screen handles locking)
      idle = {
        enabled = true;
        screenOffTimeout = 600;
        lockTimeout = 660;
        suspendTimeout = 1800;
      };
    };
  };
}
