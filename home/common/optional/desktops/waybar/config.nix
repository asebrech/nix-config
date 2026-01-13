{ config, ... }:
{
  home.file."${config.xdg.configHome}/waybar/config.jsonc" = {
    text = ''
      {
        "reload_style_on_change": true,
        "layer": "top",
        "position": "top",
        "spacing": 0,
        "height": 26,
        "modules-left": ["hyprland/workspaces"],
        "modules-center": ["clock"],
        "modules-right": [
          "tray",
          "bluetooth",
          "network",
          "pulseaudio",
          "cpu",
          "battery"
        ],
        "hyprland/workspaces": {
          "on-click": "activate",
          "format": "{icon}",
          "format-icons": {
            "default": "",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "10": "0",
            "active": "󱓻"
          },
          "persistent-workspaces": {
            "1": [],
            "2": [],
            "3": [],
            "4": [],
            "5": []
          }
        },
        "cpu": {
          "interval": 5,
          "format": "󰍛",
          "on-click": "alacritty -e btop",
          "on-click-right": "alacritty"
        },
        "clock": {
          "format": "{:L%A %H:%M}",
          "format-alt": "{:L%d %B W%V %Y}",
          "tooltip": false
        },
        "network": {
          "format-icons": ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"],
          "format": "{icon}",
          "format-wifi": "{icon}",
          "format-ethernet": "󰀂",
          "format-disconnected": "󰤮",
          "tooltip-format-wifi": "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes} ⇡{bandwidthUpBytes}",
          "tooltip-format-ethernet": "⇣{bandwidthDownBytes} ⇡{bandwidthUpBytes}",
          "tooltip-format-disconnected": "Disconnected",
          "interval": 3,
          "spacing": 1,
          "on-click": "nm-connection-editor"
        },
        "battery": {
          "format": "{capacity}% {icon}",
          "format-discharging": "{icon}",
          "format-charging": "{icon}",
          "format-plugged": "",
          "format-icons": {
            "charging": ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"],
            "default": ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
          },
          "format-full": "󰂅",
          "tooltip-format-discharging": "{power:>1.0f}W↓ {capacity}%",
          "tooltip-format-charging": "{power:>1.0f}W↑ {capacity}%",
          "interval": 5,
          "states": {
            "warning": 20,
            "critical": 10
          }
        },
        "bluetooth": {
          "format": "",
          "format-off": "󰂲",
          "format-disabled": "󰂲",
          "format-connected": "󰂱",
          "format-no-controller": "",
          "tooltip-format": "Devices connected: {num_connections}",
          "on-click": "blueman-manager"
        },
        "pulseaudio": {
          "format": "{icon}",
          "on-click": "pavucontrol",
          "on-click-right": "pamixer -t",
          "tooltip-format": "Playing at {volume}%",
          "scroll-step": 5,
          "format-muted": "",
          "format-icons": {
            "headphone": "",
            "default": ["", "", ""]
          }
        },
        "tray": {
          "icon-size": 12,
          "spacing": 17
        }
      }
    '';
  };
}
