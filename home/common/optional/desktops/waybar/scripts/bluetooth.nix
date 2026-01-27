# Bluetooth management script
# Adapted from mechabar: scripts/bluetooth.sh
{ pkgs }:
pkgs.writeShellScript "bluetooth.sh" ''
  #!/usr/bin/env bash
  # Scan, select, pair, and connect to Bluetooth devices

  TIMEOUT=10
  LIST=
  ADDRESS=

  cprintf() {
    printf "\e[31m%b\e[39m\n" "$@"
  }

  check_state() {
    local state
    state=$(${pkgs.bluez}/bin/bluetoothctl show | awk '/PowerState/ {print $2}')

    case $state in
      "off") ${pkgs.bluez}/bin/bluetoothctl power on > /dev/null ;;
      "off-blocked")
        ${pkgs.util-linux}/bin/rfkill unblock bluetooth

        local i new_state
        for ((i = 1; i <= TIMEOUT; i++)); do
          printf "\rUnblocking Bluetooth... (%d/%d)" $i $TIMEOUT
          new_state=$(${pkgs.bluez}/bin/bluetoothctl show | awk '/PowerState/ {print $2}')
          [[ $new_state == "on" ]] && break
          sleep 1
        done

        if [[ $new_state != "on" ]]; then
          ${pkgs.libnotify}/bin/notify-send "Bluetooth" "Failed to unblock" -i "package-purge"
          exit 1
        fi
        ;;
      *) return 0 ;;
    esac

    ${pkgs.libnotify}/bin/notify-send "Bluetooth On" -i "network-bluetooth-activated" \
      -h string:x-canonical-private-synchronous:bluetooth
  }

  get_devices() {
    ${pkgs.bluez}/bin/bluetoothctl -t $TIMEOUT scan on > /dev/null &

    local i num
    for ((i = 1; i <= TIMEOUT; i++)); do
      printf  "\rScanning for devices... (%d/%d)" $i $TIMEOUT
      cprintf "\nPress [q] to stop"

      num=$(${pkgs.bluez}/bin/bluetoothctl devices | grep -c "Device")
      printf "\nDevices: %d" "$num"
      printf "\e[3F"

      read -rsn 1 -t 1
      [[ $REPLY == [Qq] ]] && break
    done

    cprintf "\nScanning stopped.\n"

    LIST=$(${pkgs.bluez}/bin/bluetoothctl devices | sed "s/^Device //")
    if [[ -z $LIST ]]; then
      ${pkgs.libnotify}/bin/notify-send "Bluetooth" "No devices found" -i "package-broken"
      exit 1
    fi
  }

  select_device() {
    local header
    printf -v header "%-17s %s" "Address" "Name"

    ADDRESS=$(${pkgs.fzf}/bin/fzf \
      --border=sharp \
      --border-label=" Bluetooth Devices " \
      --ghost="Search" \
      --header="$header" \
      --height=~100% \
      --highlight-line \
      --info=inline-right \
      --pointer="" \
      --reverse <<< "$LIST" | awk '{print $1}')

    [[ -z $ADDRESS ]] && exit 1

    local connected
    connected=$(${pkgs.bluez}/bin/bluetoothctl info "$ADDRESS" | awk '/Connected/ {print $2}')

    if [[ $connected == "yes" ]]; then
      ${pkgs.libnotify}/bin/notify-send "Bluetooth" "Already connected to this device" \
        -i "package-install"
      exit 1
    fi
  }

  pair_and_connect() {
    local paired
    paired=$(${pkgs.bluez}/bin/bluetoothctl info "$ADDRESS" | awk '/Paired/ {print $2}')

    if [[ $paired == "no" ]]; then
      printf "Pairing..."
      if ! timeout $TIMEOUT ${pkgs.bluez}/bin/bluetoothctl pair "$ADDRESS" > /dev/null; then
        ${pkgs.libnotify}/bin/notify-send "Bluetooth" "Failed to pair" -i "package-purge"
        exit 1
      fi
    fi

    printf "\nConnecting..."

    if ! timeout $TIMEOUT ${pkgs.bluez}/bin/bluetoothctl connect "$ADDRESS" > /dev/null; then
      ${pkgs.libnotify}/bin/notify-send "Bluetooth" "Failed to connect" -i "package-purge"
      exit 1
    fi

    ${pkgs.libnotify}/bin/notify-send "Bluetooth" "Successfully connected" -i "package-install"
  }

  # Hide cursor
  printf "\e[?25l"

  check_state
  get_devices

  # Unhide cursor
  printf "\e[?25h"

  select_device
  pair_and_connect
''
