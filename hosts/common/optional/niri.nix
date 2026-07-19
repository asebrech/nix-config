#
# niri — scrollable-tiling Wayland compositor
# https://github.com/niri-wm/niri
#
# The nixpkgs module registers the session (visible in any display manager)
# and wires the xdg portals (gtk + gnome for screencast) and gnome-keyring.
# The shell on top (bar, launcher, notifications, lock screen, idle) is
# noctalia, configured on the home side (home/common/optional/desktops/).
#
{
  # The compositor and its session (launched by greetd auto-login,
  # see services/greetd.nix)
  programs.niri.enable = true;

  # Desktop services consumed by noctalia's bar and control center
  # (polkit and the portals are already wired by programs.niri; the GUI
  # polkit agent runs as a user service, see the home desktops module)
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
