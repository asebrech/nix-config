# HyprDynamicMonitors configuration for automatic monitor management
# Uses the official Home Manager module for proper systemd integration
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Use the official Home Manager module provided by hyprdynamicmonitors flake
  home.hyprdynamicmonitors = {
    enable = true;
    package = inputs.hyprdynamicmonitors.packages.${pkgs.system}.default;

    # Inline TOML configuration (takes precedence over configFile)
    config = ''
      [general]
      destination = "${config.home.homeDirectory}/.config/hypr/monitors.conf"
      debounce_time_ms = 500

      [notifications]
      disabled = false
      timeout_ms = 3000

      [profiles.laptop_only]
      config_file = "${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/laptop-only.conf"
      config_file_type = "static"

      [[profiles.laptop_only.conditions.required_monitors]]
      name = "eDP-1"

      [profiles.mirrored]
      config_file = "${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/mirrored.conf"
      config_file_type = "static"

      [[profiles.mirrored.conditions.required_monitors]]
      name = "eDP-1"

      [[profiles.mirrored.conditions.required_monitors]]
      name = "HDMI-A-1"
    '';

    extraFlags = [
      "--disable-power-events" # Disabled due to Asahi-specific UPower paths
      "--debug"
    ];

    installExamples = false;
    installThemes = false;

    # The module automatically creates:
    # - systemd.user.services.hyprdynamicmonitors (main daemon)
    # - systemd.user.services.hyprdynamicmonitors-prepare (boot cleanup)
    # Both bound to graphical-session.target by default
  };

  # Create profile configuration files
  home.file."${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/laptop-only.conf".text =
    ''
      monitor = eDP-1,3456x2160@60,0x0,1.5
    '';

  home.file."${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/mirrored.conf".text =
    ''
      # External monitor - the source for mirroring
      monitor = HDMI-A-1,3840x2160@60,0x0,1.0
      # Laptop display - mirrors the external monitor
      # All parameters required: resolution, position, scale, then mirror keyword
      monitor = eDP-1,3456x2160@60,0x0,1.0,mirror,HDMI-A-1
    '';

  # NOTE: Do NOT create ~/.config/hypr/monitors.conf here!
  # hyprdynamicmonitors manages this file itself (creates symlink or generates it).
  # Creating it here causes conflicts during home-manager activation.
  # The hyprdynamicmonitors-prepare.service handles initial setup before Hyprland starts.
}
