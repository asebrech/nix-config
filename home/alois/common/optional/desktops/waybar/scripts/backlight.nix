# Backlight control script
# Adapted from mechabar: scripts/backlight.sh
{ pkgs }:
pkgs.writeShellScript "backlight.sh" ''
  #!/usr/bin/env bash
  # Adjust screen brightness and send a notification

  DEF_VALUE=1
  action=$1
  value=''${2:-$DEF_VALUE}

  if [[ "$action" == "up" ]]; then
    sign="+"
  elif [[ "$action" == "down" ]]; then
    sign="-"
  else
    echo "Usage: $0 {up|down} [value]"
    exit 1
  fi

  ${pkgs.brightnessctl}/bin/brightnessctl -n set "$value%$sign" > /dev/null

  level=$(${pkgs.brightnessctl}/bin/brightnessctl -m | awk -F "," '{print $4}')

  ${pkgs.libnotify}/bin/notify-send "Brightness: $level" -h int:value:"$level" -i \
    "contrast" -h string:x-canonical-private-synchronous:backlight
''
