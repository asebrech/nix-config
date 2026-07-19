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

      # Launcher opens terminal apps in ghostty; clipboard history is off
      # by default and needs cliphist (installed in ./default.nix)
      appLauncher = {
        terminalCommand = "ghostty -e";
        enableClipboardHistory = true;
      };

      # Weather/calendar location
      location.name = "Nice";

      # Idle management is off by default; enabling it uses the stock
      # timeouts (screen off 10min, built-in lock 11min, suspend 30min)
      idle.enabled = true;
    };
  };
}
