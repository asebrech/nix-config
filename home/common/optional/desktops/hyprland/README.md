# Hyprland Configuration

ML4W-inspired modular Hyprland configuration adapted for NixOS with Stylix theming.

## Structure

```
hyprland/
├── default.nix              # Main entry point - imports all modules
├── hyprland.nix             # Core Hyprland settings
├── hypridle.nix             # Idle management
├── hyprlock.nix             # Lock screen (Stylix themed)
├── hyprpaper.nix            # Wallpaper engine
├── autostart.nix            # Autostart applications
├── xdph.nix                 # XDG Desktop Portal
│
└── conf/                    # Modular configuration
    ├── animations/          # Animation variants
    │   ├── default.nix      # Import selector
    │   ├── standard.nix     # ML4W default
    │   ├── end4.nix         # End-4 style
    │   ├── smooth.nix       # Smooth animations
    │   └── disabled.nix     # No animations
    │
    ├── decorations/         # Decoration variants
    │   ├── default.nix      # Import selector
    │   ├── standard.nix     # ML4W default
    │   ├── blur.nix         # Enhanced blur
    │   ├── minimal.nix      # Minimal decorations
    │   └── gamemode.nix     # Gaming optimized
    │
    ├── windows/             # Window layout variants
    │   ├── default.nix      # Import selector
    │   ├── standard.nix     # ML4W default
    │   ├── border-2.nix     # Thick borders
    │   ├── transparent.nix  # More transparency
    │   └── gamemode.nix     # No gaps
    │
    ├── keybindings/         # Keybinding layouts
    │   ├── default.nix      # Import selector
    │   ├── standard.nix     # ML4W default
    │   └── custom.nix       # User overrides
    │
    ├── monitors/            # Monitor configurations
    │   ├── default.nix      # Import selector
    │   ├── standard.nix     # Host-based config
    │   ├── laptop.nix       # Single screen
    │   ├── desktop.nix      # Multi-monitor
    │   └── gamemode.nix     # High refresh rate
    │
    ├── environments/        # Environment variables
    │   ├── default.nix      # Import selector
    │   ├── standard.nix     # ML4W default
    │   ├── hidpi.nix        # 4K/HiDPI scaling
    │   ├── nvidia.nix       # NVIDIA optimized
    │   └── kvm.nix          # VM environment
    │
    ├── windowrules/         # Window rules
    │   ├── default.nix      # Import selector
    │   ├── standard.nix     # ML4W default
    │   └── custom.nix       # User rules
    │
    ├── input.nix            # Input device settings
    └── misc.nix             # Misc Hyprland settings
```

## Switching Variants

To switch between variants, edit the `default.nix` file in the respective subdirectory:

### Example: Change animation style

Edit `conf/animations/default.nix`:

```nix
{ ... }:
{
  imports = [
    # ./standard.nix # ML4W default
    ./end4.nix       # End-4 style (active)
    # ./smooth.nix
    # ./disabled.nix
  ];
}
```

### Example: Use HiDPI environment

Edit `conf/environments/default.nix`:

```nix
{ ... }:
{
  imports = [
    # ./standard.nix
    ./hidpi.nix      # 4K/HiDPI (active)
    # ./nvidia.nix
  ];
}
```

## Key Features

- **Modular Design**: Each aspect of Hyprland is in its own module
- **Variant System**: Easy switching between different styles and configurations
- **Stylix Integration**: Colors and theming managed by Stylix
- **ML4W Inspired**: Based on ML4W dotfiles structure but adapted for Nix
- **Host-Specific**: Monitor configuration reads from host settings

## Customization

1. **Quick tweaks**: Edit the `standard.nix` files directly
2. **New variants**: Create new variant files (e.g., `animations/custom.nix`)
3. **User overrides**: Use `custom.nix` files for personal additions
4. **Host-specific**: Configure monitors in your host configuration

## Reference

Based on:
- [ML4W Dotfiles](https://github.com/mylinuxforwork/dotfiles)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- Adapted for NixOS with Stylix theming
