# Bluetooth module
# From mechabar: modules/bluetooth.jsonc
let
  scriptsPath = "~/.config/waybar/scripts";
  # Exact icons from mechabar
  iconDefault = "󰂯";
  iconDisabled = "󰂲";
  iconOff = "󰂲";
  iconOn = "󰂰";
  iconConnected = "󰂱";
in
{
  # Source: modules/bluetooth.jsonc
  bluetooth = {
    format = iconDefault;
    format-disabled = iconDisabled;
    format-off = iconOff;
    format-on = iconOn;
    format-connected = iconConnected;
    min-length = 2;
    max-length = 2;
    on-click = "foot -e ${scriptsPath}/bluetooth.sh";
    on-click-right = "bluetoothctl power off && notify-send 'Bluetooth Off' -i 'network-bluetooth-inactive' -h string:x-canonical-private-synchronous:bluetooth";
    tooltip-format = "Device Addr: {device_address}";
    tooltip-format-disabled = "Bluetooth Disabled";
    tooltip-format-off = "Bluetooth Off";
    tooltip-format-on = "Bluetooth Disconnected";
    tooltip-format-connected = "Device: {device_alias}";
    tooltip-format-enumerate-connected = "Device: {device_alias}";
    tooltip-format-connected-battery = "Device: {device_alias}\nBattery: {device_battery_percentage}%";
    tooltip-format-enumerate-connected-battery = "Device: {device_alias}\nBattery: {device_battery_percentage}%";
  };
}
