#
# COSMIC desktop environment (System76)
# https://system76.com/cosmic
#
# Complete out-of-the-box desktop: compositor with auto-tiling and window
# stacks, launcher, panel, notifications, settings app, lock screen, and
# the cosmic-greeter display manager. Configuration lives in the COSMIC
# Settings app (persisted under ~/.config/cosmic), not in this repo.
#
{
  # The desktop itself
  services.desktopManager.cosmic.enable = true;

  # cosmic-greeter as the display manager (replaces greetd/tuigreet)
  services.displayManager.cosmic-greeter.enable = true;
}
