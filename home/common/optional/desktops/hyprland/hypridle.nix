# Hypridle - Idle management daemon
# Adapted from ML4W dotfiles: https://github.com/mylinuxforwork/dotfiles
# Automatically locks screen and manages power
{ pkgs, ... }:
let
  # Smart suspend script that only suspends if no external monitors are connected
  # This avoids HDMI detection issues on Asahi Linux after resume
  # CRITICAL: In clamshell mode, eDP-1 (laptop screen) is disabled, so we must check
  # for external monitors specifically, not just count total monitors
  smartSuspend = pkgs.writeShellScript "smart-suspend" ''
    # Check if any external (non-eDP) monitors are connected
    # This is critical for clamshell mode where the laptop screen (eDP-1) is disabled
    # but an external HDMI monitor is active. Counting total monitors would incorrectly
    # report "1" and trigger suspend, causing HDMI wake issues.
    EXTERNAL_MONITORS=$(${pkgs.hyprland}/bin/hyprctl monitors -j | \
      ${pkgs.jq}/bin/jq '[.[] | select(.name != "eDP-1")] | length')

    # If any external monitors exist, don't suspend (prevents HDMI/Bluetooth issues)
    # Apple DCP driver has known issues with HDMI Hot Plug Detect after suspend
    # Additionally, Bluetooth devices may disconnect and fail to reconnect
    if [ "$EXTERNAL_MONITORS" -gt 0 ]; then
      echo "External monitor(s) detected, skipping suspend to avoid HDMI/Bluetooth issues"
      exit 0
    fi

    # Only laptop screen or no monitors, safe to suspend
    ${pkgs.systemd}/bin/systemctl suspend
  '';
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend
        after_sleep_cmd = "hyprctl dispatch dpms on"; # avoid having to press a key twice to turn on display
        ignore_dbus_inhibit = false;
      };

      listener = [
        # Dim monitor backlight
        {
          timeout = 480; # 8min
          on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED
          on-resume = "brightnessctl -r"; # monitor backlight restore
        }
        # Lock screen
        {
          timeout = 600; # 10min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }
        # Turn off display
        {
          timeout = 660; # 11min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on when activity detected
        }
        # Suspend system
        {
          timeout = 1800; # 30min
          on-timeout = toString smartSuspend; # smart suspend: only if no external monitors
        }
      ];
    };
  };
}
