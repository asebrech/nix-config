# Hypridle - Idle management daemon
# Adapted from ML4W dotfiles: https://github.com/mylinuxforwork/dotfiles
# Automatically locks screen and manages power
{ ... }:
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
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };
}
