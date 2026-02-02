# Network module
# From mechabar: modules/network.jsonc
let
  scriptsPath = "~/.config/waybar/scripts";
in
{
  # Source: modules/network.jsonc
  network = {
    interval = 10;
    format = "󰤨";
    format-ethernet = "󰈀";
    format-wifi = "{icon}";
    format-disconnected = "󰤯";
    format-disabled = "󰤮";
    format-icons = [
      "󰤟"
      "󰤢"
      "󰤥"
      "󰤨"
    ];
    min-length = 2;
    max-length = 2;
    on-click = "alacritty -e ${scriptsPath}/network.sh";
    on-click-right = "nmcli radio wifi off && notify-send 'Wi-Fi Disabled' -i 'network-wireless-off' -h string:x-canonical-private-synchronous:network";
    tooltip-format = "<b>Gateway</b>: {gwaddr}";
    tooltip-format-ethernet = "<b>Interface</b>: {ifname}";
    tooltip-format-wifi = "<b>Network</b>: {essid}\n<b>IP Addr</b>: {ipaddr}/{cidr}\n<b>Strength</b>: {signalStrength}%\n<b>Frequency</b>: {frequency} GHz";
    tooltip-format-disconnected = "Wi-Fi Disconnected";
    tooltip-format-disabled = "Wi-Fi Disabled";
  };
}
