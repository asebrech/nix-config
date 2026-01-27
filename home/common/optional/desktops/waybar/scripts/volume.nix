# Volume control script
# Adapted from mechabar: scripts/volume.sh
{ pkgs }:
pkgs.writeShellScript "volume.sh" ''
  #!/usr/bin/env bash
  # Adjust default device volume and send a notification with the current level

  DEF_VALUE=1
  MIN=0
  MAX=100

  DEVICE=$1
  ACTION=$2
  VALUE=''${3:-$DEF_VALUE}

  case $DEVICE in
    "input")
      DEV_DEF="@DEFAULT_SOURCE@"
      DEV_STATE="source-mute"
      DEV_VOLUME="source-volume"
      DEV_ICON="mic-volume"
      DEV_NAME="Microphone"
      ;;
    "output")
      DEV_DEF="@DEFAULT_SINK@"
      DEV_STATE="sink-mute"
      DEV_VOLUME="sink-volume"
      DEV_ICON="audio-volume"
      DEV_NAME="Volume"
      ;;
    *)
      echo "Usage: $0 {input|output} {mute|raise|lower} [value]"
      exit 1
      ;;
  esac

  pactl_cmd() {
    ${pkgs.pulseaudio}/bin/pactl "$1" "$DEV_DEF" "''${@:2}"
  }

  get_state() {
    local state
    state=$(pactl_cmd "get-$DEV_STATE" | awk '{print $2}')
    case $state in
      "yes") printf "Muted" ;;
      "no")  printf "Unmuted" ;;
    esac
  }

  get_volume() {
    pactl_cmd "get-$DEV_VOLUME" | awk '{print $5}' | tr -d "%"
  }

  get_icon() {
    local state level new_level
    state=$(get_state)
    level=$(get_volume)
    new_level=''${1:-$level}

    if [[ $state == "Muted" ]]; then
      printf "%s" "$DEV_ICON-muted"
    else
      if ((new_level < MAX * 33 / 100)); then
        printf "%s" "$DEV_ICON-low"
      elif ((new_level < MAX * 66 / 100)); then
        printf "%s" "$DEV_ICON-medium"
      else
        printf "%s" "$DEV_ICON-high"
      fi
    fi
  }

  set_state() {
    pactl_cmd "set-$DEV_STATE" toggle
    local state icon
    state=$(get_state)
    icon=$(get_icon)
    ${pkgs.libnotify}/bin/notify-send "$DEV_NAME: $state" -i "$icon" \
      -h string:x-canonical-private-synchronous:volume
  }

  set_volume() {
    local level new_level
    level=$(get_volume)

    case $ACTION in
      "raise")
        new_level=$((level + VALUE))
        ((new_level > MAX)) && new_level=$MAX
        ;;
      "lower")
        new_level=$((level - VALUE))
        ((new_level < MIN)) && new_level=$MIN
        ;;
    esac

    pactl_cmd "set-$DEV_VOLUME" "$new_level%"

    local icon
    icon=$(get_icon $new_level)
    ${pkgs.libnotify}/bin/notify-send "$DEV_NAME: $new_level%" -h int:value:$new_level -i "$icon" \
      -h string:x-canonical-private-synchronous:volume
  }

  case $ACTION in
    "mute")            set_state ;;
    "raise" | "lower") set_volume ;;
    *)
      echo "Usage: $0 {input|output} {mute|raise|lower} [value]"
      exit 1
      ;;
  esac
''
