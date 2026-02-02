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

      [notifications]
      disabled = false
      timeout_ms = 3000

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
      "--disable-power-events"
      "--debug"
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
      monitor={{$laptop.Name}},${toString primaryMonitor.width}x${toString primaryMonitor.height}@${toString primaryMonitor.refreshRate},0x0,1.0,mirror,{{.Name}}
      {{- end }}
    '';
}
