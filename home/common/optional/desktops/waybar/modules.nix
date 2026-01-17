{ pkgs, ... }:
{
  # Waybar module definitions adapted from ML4W dotfiles
  # Stylix handles colors, we keep the structure and functionality

  "hyprland/workspaces" = {
    on-scroll-up = "hyprctl dispatch workspace r-1";
    on-scroll-down = "hyprctl dispatch workspace r+1";
    on-click = "activate";
    active-only = false;
    all-outputs = true;
    format = "{}";
    format-icons = {
      urgent = "";
      active = "";
      default = "";
    };
    persistent-workspaces = {
      "*" = 5;
    };
  };

  "wlr/taskbar" = {
    format = "{icon}";
    icon-size = 18;
    tooltip-format = "{title}";
    on-click = "activate";
    on-click-middle = "close";
    ignore-list = [
      "Alacritty"
    ];
    rewrite = {
      "Firefox Web Browser" = "Firefox";
    };
  };

  "hyprland/window" = {
    max-length = 60;
    rewrite = {
      "(.*) - Brave" = "$1";
      "(.*) - Chromium" = "$1";
      "(.*) - Firefox" = "$1";
    };
    separate-outputs = true;
  };

  "custom/cliphist" = {
    format = "";
    on-click = "sleep 0.1 && copyq toggle";
    tooltip-format = "Clipboard Manager";
  };

  tray = {
    icon-size = 21;
    spacing = 10;
  };

  clock = {
    format = "{:%H:%M %a}";
    timezone = "";
    tooltip = false;
  };

  cpu = {
    format = "/ C {usage}% ";
    on-click = "${pkgs.alacritty}/bin/alacritty -e btop";
  };

  memory = {
    format = "/ M {}% ";
    on-click = "${pkgs.alacritty}/bin/alacritty -e btop";
  };

  disk = {
    interval = 30;
    format = "D {percentage_used}% ";
    path = "/";
    on-click = "${pkgs.alacritty}/bin/alacritty -e btop";
  };

  "hyprland/language" = {
    format = "/ K {short}";
  };

  "group/hardware" = {
    orientation = "inherit";
    drawer = {
      transition-duration = 300;
      children-class = "not-memory";
      transition-left-to-right = false;
    };
    modules = [
      "disk"
      "cpu"
      "memory"
      "hyprland/language"
    ];
  };

  network = {
    format = "{ifname}";
    format-wifi = " {signalStrength}%";
    format-ethernet = "  {ifname}";
    format-disconnected = "Disconnected ⚠";
    tooltip-format = " {ifname} via {gwaddri}";
    tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
    tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
    tooltip-format-disconnected = "Disconnected";
    max-length = 50;
    on-click = "nm-connection-editor";
  };

  battery = {
    interval = 1;
    states = {
      warning = 30;
      critical = 15;
    };
    format = "{icon} {capacity}%";
    format-charging = "  {capacity}%";
    format-plugged = "  {capacity}%";
    format-alt = "{icon}  {time}";
    format-icons = [
      " "
      " "
      " "
      " "
      " "
    ];
  };

  "power-profiles-daemon" = {
    format = "{icon}";
    tooltip-format = "Power profile: {profile}\nDriver: {driver}";
    tooltip = true;
    format-icons = {
      default = "";
      performance = "";
      balanced = "";
      power-saver = "";
    };
  };

  pulseaudio = {
    format = "{icon}  {volume}%";
    format-bluetooth = "{volume}% {icon} {format_source}";
    format-bluetooth-muted = " {icon} {format_source}";
    format-muted = " {format_source}";
    format-source = "{volume}% ";
    format-source-muted = "";
    format-icons = {
      headphone = " ";
      hands-free = " ";
      headset = " ";
      phone = " ";
      portable = " ";
      car = " ";
      default = [
        ""
        ""
        ""
      ];
    };
    on-click = "pavucontrol";
  };

  bluetooth = {
    format = " {status}";
    format-disabled = "";
    format-off = "";
    interval = 30;
    on-click = "blueman-manager";
    tooltip-format-connected = "Connected devices: {num_connections} connected\n\n{device_enumerate}";
    tooltip-format-enumerate-connected = "{device_alias}";
    tooltip-format-enumerate-connected-battery = "{device_alias}\t| Battery life: {device_battery_percentage}%";
    format-no-controller = "";
  };

  backlight = {
    format = "{icon} {percent}%";
    format-icons = [
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
    ];
    scroll-step = 1;
  };
}
