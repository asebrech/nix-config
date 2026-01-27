# Waybar modules index
# Re-exports all module configurations
#
# Structure (matching mechabar):
#   hyprland/     - Hyprland-specific modules (workspaces, window, windowcount)
#   custom/       - Custom modules (dividers, user, distro, power-menu, system-update)
#   extras/       - Extra modules (taskbar, tray, wireplumber)
#   Individual:   - backlight, battery, bluetooth, clock, cpu, idle_inhibitor,
#                   memory, mpris, network, pulseaudio, temperature
let
  # Folders
  hyprland = import ./hyprland;
  custom = import ./custom;
  extras = import ./extras;

  # Individual modules
  backlight = import ./backlight.nix;
  battery = import ./battery.nix { };
  bluetooth = import ./bluetooth.nix;
  clock = import ./clock.nix { };
  cpu = import ./cpu.nix;
  idle_inhibitor = import ./idle_inhibitor.nix { };
  memory = import ./memory.nix;
  mpris = import ./mpris.nix { };
  network = import ./network.nix;
  pulseaudio = import ./pulseaudio.nix;
  temperature = import ./temperature.nix;
in
hyprland
// custom
// extras
// backlight
// battery
// bluetooth
// clock
// cpu
// idle_inhibitor
// memory
// mpris
// network
// pulseaudio
// temperature
