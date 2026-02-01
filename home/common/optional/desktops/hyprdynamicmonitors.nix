# HyprDynamicMonitors configuration for automatic monitor management
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.hyprdynamicmonitors = {
    enable = true;
    package = inputs.hyprdynamicmonitors.packages.${pkgs.system}.default;
    configPath = "${config.home.homeDirectory}/.config/hyprdynamicmonitors/config.toml";

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
      "--disable-power-events"
      "--debug"
    ];

    installExamples = false;
    installThemes = false;
  };

  # Create profile config files
  home.file."${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/laptop-only.conf".text =
    ''
      monitor = eDP-1,3456x2160@60,0x0,1.5
    '';

  home.file."${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/mirrored.conf".text =
    ''
      monitor = HDMI-A-1,3840x2160@60,0x0,1.0
      monitor = eDP-1,preferred,auto,1,mirror,HDMI-A-1
    '';

  # Ensure output directory exists
  home.file."${config.home.homeDirectory}/.config/hypr/.keep".text = "";
}
