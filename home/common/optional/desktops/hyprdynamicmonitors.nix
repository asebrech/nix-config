{
  config,
  pkgs,
  inputs,
  osConfig,
  ...
}:
let
  primaryMonitor = builtins.head osConfig.monitors;

  # Brightness state file for preserving user's brightness preference across lid close/open
  brightnessStateFile = "/tmp/lid-brightness-save-\${USER}";

  # Lid close script: save brightness, lock, dim, and turn off internal display
  # Uses verbose logging for debugging via journalctl -t lid-handler
  # Includes validation checks to prevent config errors
  lidCloseScript = pkgs.writeShellScript "lid-close" ''
    ${pkgs.util-linux}/bin/logger -t lid-handler "Lid closed event triggered"

    # Verify Hyprland is running before proceeding
    if ! ${pkgs.hyprland}/bin/hyprctl version >/dev/null 2>&1; then
      ${pkgs.util-linux}/bin/logger -t lid-handler "ERROR: Hyprland not responding, aborting lid close handler"
      exit 1
    fi

    # Check if external monitors are connected
    if ! EXTERNAL_COUNT=$(${pkgs.hyprland}/bin/hyprctl monitors -j 2>/dev/null | ${pkgs.jq}/bin/jq '[.[] | select(.name != "eDP-1")] | length' 2>/dev/null); then
      ${pkgs.util-linux}/bin/logger -t lid-handler "ERROR: Failed to detect monitors, assuming no external"
      EXTERNAL_COUNT=0
    fi
    ${pkgs.util-linux}/bin/logger -t lid-handler "External monitors detected: $EXTERNAL_COUNT"

    # Verify eDP-1 exists before attempting operations
    if ! ${pkgs.hyprland}/bin/hyprctl monitors -j 2>/dev/null | ${pkgs.jq}/bin/jq -e '.[] | select(.name == "eDP-1")' >/dev/null 2>&1; then
      ${pkgs.util-linux}/bin/logger -t lid-handler "WARNING: eDP-1 not detected, skipping brightness/DPMS operations"
      exit 0
    fi

    # Save current brightness before dimming
    if CURRENT_BRIGHTNESS=$(${pkgs.brightnessctl}/bin/brightnessctl -d apple-panel-bl get 2>/dev/null); then
      echo "$CURRENT_BRIGHTNESS" > "${brightnessStateFile}"
      ${pkgs.util-linux}/bin/logger -t lid-handler "Saved brightness: $CURRENT_BRIGHTNESS"
    else
      ${pkgs.util-linux}/bin/logger -t lid-handler "WARNING: Failed to read current brightness"
    fi

    if [ "$EXTERNAL_COUNT" -gt 0 ]; then
      # Clamshell mode: Only dim backlight (keep display enabled for mirroring)
      # Do NOT disable eDP-1 - hyprdynamicmonitors needs it active for mirroring profile
      ${pkgs.util-linux}/bin/logger -t lid-handler "Clamshell mode: dimming backlight only (mirroring active)"
      ${pkgs.brightnessctl}/bin/brightnessctl -d apple-panel-bl set 0% 2>/dev/null || ${pkgs.util-linux}/bin/logger -t lid-handler "WARNING: brightness control failed"
    else
      # No external monitors: Lock, dim, and turn off display
      ${pkgs.util-linux}/bin/logger -t lid-handler "Single display mode: locking and powering off"
      ${pkgs.systemd}/bin/loginctl lock-session 2>/dev/null || ${pkgs.util-linux}/bin/logger -t lid-handler "WARNING: lock-session failed"
      ${pkgs.brightnessctl}/bin/brightnessctl -d apple-panel-bl set 0% 2>/dev/null || ${pkgs.util-linux}/bin/logger -t lid-handler "WARNING: brightness control failed"
      ${pkgs.hyprland}/bin/hyprctl dispatch dpms off eDP-1 2>/dev/null || ${pkgs.util-linux}/bin/logger -t lid-handler "WARNING: DPMS off failed"
    fi

    ${pkgs.util-linux}/bin/logger -t lid-handler "Lid close handling completed"
  '';

  # Lid open script: restore brightness and re-enable internal display
  # Preserves user's brightness preference from before lid close
  # Includes validation checks to prevent errors
  lidOpenScript = pkgs.writeShellScript "lid-open" ''
    ${pkgs.util-linux}/bin/logger -t lid-handler "Lid open event triggered"

    # Verify Hyprland is running before proceeding
    if ! ${pkgs.hyprland}/bin/hyprctl version >/dev/null 2>&1; then
      ${pkgs.util-linux}/bin/logger -t lid-handler "ERROR: Hyprland not responding, aborting lid open handler"
      exit 1
    fi

    # Check if external monitors are connected
    if ! EXTERNAL_COUNT=$(${pkgs.hyprland}/bin/hyprctl monitors -j 2>/dev/null | ${pkgs.jq}/bin/jq '[.[] | select(.name != "eDP-1")] | length' 2>/dev/null); then
      ${pkgs.util-linux}/bin/logger -t lid-handler "ERROR: Failed to detect monitors, assuming no external"
      EXTERNAL_COUNT=0
    fi
    ${pkgs.util-linux}/bin/logger -t lid-handler "External monitors detected: $EXTERNAL_COUNT"

    # Verify eDP-1 exists before attempting operations
    if ! ${pkgs.hyprland}/bin/hyprctl monitors -j 2>/dev/null | ${pkgs.jq}/bin/jq -e '.[] | select(.name == "eDP-1")' >/dev/null 2>&1; then
      ${pkgs.util-linux}/bin/logger -t lid-handler "WARNING: eDP-1 not detected, skipping restore operations"
      exit 0
    fi

    # eDP-1 stays enabled in clamshell mode (needed for mirroring)
    # Just restore display power and brightness
    ${pkgs.util-linux}/bin/logger -t lid-handler "Restoring display power and brightness"
    ${pkgs.hyprland}/bin/hyprctl dispatch dpms on eDP-1 2>/dev/null || ${pkgs.util-linux}/bin/logger -t lid-handler "WARNING: DPMS on failed"

    # Restore saved brightness or use default
    if [ -f "${brightnessStateFile}" ]; then
      SAVED_BRIGHTNESS=$(cat "${brightnessStateFile}" 2>/dev/null)
      if [ -n "$SAVED_BRIGHTNESS" ] && [ "$SAVED_BRIGHTNESS" -gt 0 ] 2>/dev/null; then
        ${pkgs.brightnessctl}/bin/brightnessctl -d apple-panel-bl set "$SAVED_BRIGHTNESS" 2>/dev/null || ${pkgs.util-linux}/bin/logger -t lid-handler "WARNING: brightness restore failed"
        ${pkgs.util-linux}/bin/logger -t lid-handler "Restored brightness: $SAVED_BRIGHTNESS"
      else
        ${pkgs.brightnessctl}/bin/brightnessctl -d apple-panel-bl set 50% 2>/dev/null
        ${pkgs.util-linux}/bin/logger -t lid-handler "Invalid saved brightness, using default: 50%"
      fi
    else
      ${pkgs.brightnessctl}/bin/brightnessctl -d apple-panel-bl set 50% 2>/dev/null
      ${pkgs.util-linux}/bin/logger -t lid-handler "No saved brightness found, using default: 50%"
    fi

    ${pkgs.util-linux}/bin/logger -t lid-handler "Lid open handling completed"
  '';

  # Lid monitor daemon: watches UPower DBus for lid state changes
  # Runs as systemd user service, applies 5-second debounce on lid close
  lidMonitorScript = pkgs.writeShellScript "lid-monitor" ''
    ${pkgs.util-linux}/bin/logger -t lid-handler "Lid monitor daemon started"

    # Monitor UPower for LidIsClosed property changes via gdbus
    ${pkgs.glib}/bin/gdbus monitor --system --dest org.freedesktop.UPower --object-path /org/freedesktop/UPower | \
    while read -r line; do
      if echo "$line" | ${pkgs.gnugrep}/bin/grep -q "LidIsClosed.*true"; then
        ${pkgs.util-linux}/bin/logger -t lid-handler "DBus signal: Lid closed detected, applying 5-second debounce"
        sleep 5
        ${lidCloseScript}
      elif echo "$line" | ${pkgs.gnugrep}/bin/grep -q "LidIsClosed.*false"; then
        ${pkgs.util-linux}/bin/logger -t lid-handler "DBus signal: Lid open detected"
        ${lidOpenScript}
      fi
    done
  '';
in
{
  # Export lid monitor script path for use in systemd service (home/asahi.nix)
  home.sessionVariables = {
    LID_MONITOR_SCRIPT = "${lidMonitorScript}";
  };

  # Make lid monitor script available in packages for systemd to reference
  home.packages = [
    (pkgs.writeScriptBin "lid-monitor-daemon" (builtins.readFile lidMonitorScript))
  ];
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

      # Power events - Asahi-specific power line path for Apple Silicon
      [power_events]
      [power_events.dbus_query_object]
      destination = "org.freedesktop.UPower"
      path = "/org/freedesktop/UPower/devices/line_power_macsmc_ac"
      method = "org.freedesktop.DBus.Properties.Get"
      expected_discharging_value = "false"

      [[power_events.dbus_query_object.args]]
      arg = "org.freedesktop.UPower.Device"

      [[power_events.dbus_query_object.args]]
      arg = "Online"

      [[power_events.dbus_signal_match_rules]]
      interface = "org.freedesktop.DBus.Properties"
      member = "PropertiesChanged"
      object_path = "/org/freedesktop/UPower/devices/line_power_macsmc_ac"

      # Note: Lid event handling is done via separate systemd service (lid-handler)
      # See home/asahi.nix for the systemd service configuration
      # hyprdynamicmonitors' lid_events only supports profile selection, not script execution

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

      [[profiles.with_external.conditions.required_monitors]]
      name = "(HDMI|DP).*"
      match_name_using_regex = true
      monitor_tag = "external"
    '';

    extraFlags = [
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
      {{- $external := index .MonitorsByTag "external" -}}
      {{- if and $laptop $external }}
      monitor={{$external.Name}},preferred,0x0,1.0
      monitor={{$laptop.Name}},${toString primaryMonitor.width}x${toString primaryMonitor.height}@${toString primaryMonitor.refreshRate},0x0,${toString primaryMonitor.scale},mirror,{{$external.Name}}
      {{- end }}
    '';
}
