{
  config,
  pkgs,
  inputs,
  osConfig,
  ...
}:
let
  primaryMonitor = builtins.head osConfig.monitors;
in
{
  home.hyprdynamicmonitors = {
    enable = true;
    package = inputs.hyprdynamicmonitors.packages.${pkgs.system}.default;

    config = ''
      [general]
      destination = "${config.home.homeDirectory}/.config/hypr/monitors.conf"
      debounce_time_ms = 500
      exec_on_change = "${pkgs.systemd}/bin/systemctl --user restart waybar.service"

      [notifications]
      disabled = false
      timeout_ms = 3000

      [power_events.dbus_query_object]
      path = "/org/freedesktop/UPower/devices/line_power_macsmc_ac"

      [[power_events.dbus_signal_match_rules]]
      object_path = "/org/freedesktop/UPower/devices/line_power_macsmc_ac"

      [lid_events]
      disabled = false

      [lid_events.dbus_query_object]
      path = "/org/freedesktop/UPower"

      [[lid_events.dbus_signal_match_rules]]
      object_path = "/org/freedesktop/UPower"

      [profiles.single]
      config_file = "${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/single.conf"
      config_file_type = "static"

      [[profiles.single.conditions.required_monitors]]
      name = "${primaryMonitor.name}"

      [profiles.with_external]
      config_file = "${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/external.go.tmpl"
      config_file_type = "template"

      [[profiles.with_external.conditions.required_monitors]]
      name = "${primaryMonitor.name}"
      monitor_tag = "laptop"
    '';

    extraFlags = [
      "--debug"
      "--enable-lid-events"
    ];

    installExamples = false;
    installThemes = false;
  };

  home.file."${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/single.conf".text = ''
    monitor = ${primaryMonitor.name},${toString primaryMonitor.width}x${toString primaryMonitor.height}@${toString primaryMonitor.refreshRate},${toString primaryMonitor.x}x${toString primaryMonitor.y},${toString primaryMonitor.scale}
  '';

  home.file."${config.home.homeDirectory}/.config/hyprdynamicmonitors/profiles/external.go.tmpl".text =
    ''
      {{- $laptop := index .MonitorsByTag "laptop" -}}
      {{- range .ExtraMonitors}}
      monitor={{.Name}},preferred,0x0,1.0
      {{- end }}
      {{- if isLidClosed}}
      monitor={{$laptop.Name}},disable
      {{- else}}
      {{- range .ExtraMonitors}}
      monitor={{$laptop.Name}},${toString primaryMonitor.width}x${toString primaryMonitor.height}@${toString primaryMonitor.refreshRate},0x0,1.0,mirror,{{.Name}}
      {{- end }}
      {{- end }}
    '';
}
