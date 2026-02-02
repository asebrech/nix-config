{
  config,
  pkgs,
  inputs,
  osConfig,
  ...
}:
let
  laptopMonitor = builtins.head osConfig.monitors;
in
{
  home.hyprdynamicmonitors = {
    enable = true;
    package = inputs.hyprdynamicmonitors.packages.${pkgs.system}.default;

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
      name = "${laptopMonitor.name}"

      [profiles.mirrored]
      config_file = "${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/mirrored.conf"
      config_file_type = "static"

      [[profiles.mirrored.conditions.required_monitors]]
      name = "${laptopMonitor.name}"

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

  home.file."${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/laptop-only.conf".text =
    ''
      monitor = ${laptopMonitor.name},${toString laptopMonitor.width}x${toString laptopMonitor.height}@${toString laptopMonitor.refreshRate},${toString laptopMonitor.x}x${toString laptopMonitor.y},${toString laptopMonitor.scale}
    '';

  home.file."${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/mirrored.conf".text =
    ''
      monitor = HDMI-A-1,3840x2160@60,0x0,1.0
      monitor = ${laptopMonitor.name},${toString laptopMonitor.width}x${toString laptopMonitor.height}@${toString laptopMonitor.refreshRate},0x0,1.0,mirror,HDMI-A-1
    '';
}
