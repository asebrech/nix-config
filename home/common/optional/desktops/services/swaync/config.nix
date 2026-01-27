#
# SwayNotificationCenter settings (config.json)
# Adapted from: https://github.com/cebem1nt/dotfiles
#
{
  "$schema" = "/etc/xdg/swaync/configschema.json";
  positionX = "right";
  positionY = "top";
  cssPriority = "user";

  control-center-width = 450;
  fit-to-screen = true;

  notification-window-width = 400;
  notification-icon-size = 40;
  notification-body-image-height = 500;
  notification-body-image-width = 500;
  notification-inline-replies = true;
  notification-2fa-action = false;

  timeout = 4;
  timeout-low = 4;
  timeout-critical = 6;

  keyboard-shortcuts = true;
  image-visibility = "when-available";
  transition-time = 200;
  hide-on-clear = false;
  hide-on-action = false;
  script-fail-notify = true;

  widgets = [
    "mpris"
    "backlight"
    "volume"
    "dnd"
    "notifications"
    "buttons-grid"
  ];

  widget-config = {
    backlight = {
      label = "󰃠"; # nf-md-brightness_6
      slider = true;
      min = 10;
    };

    volume = {
      device = "default";
      label = "󰕾"; # nf-md-volume_high
      slider = true;
    };

    dnd = {
      text = "Do not disturb";
    };

    mpris = {
      image-size = 110;
      image-radius = 12;
      autohide = false;
      blacklist = [ "org.mpris.MediaPlayer2.playerctld" ];
    };

    buttons-grid = {
      actions = [
        {
          # WiFi toggle
          label = "󰖩"; # nf-md-wifi
          type = "toggle";
          active = true;
          command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
          update-command = "sh -c '[[ $(nmcli r wifi) == \"enabled\" ]] && echo true || echo false'";
        }
        {
          # Bluetooth toggle
          label = "󰂯"; # nf-md-bluetooth
          type = "toggle";
          active = true;
          command = "rfkill toggle bluetooth";
          update-command = "sh -c '[[ $(rfkill list bluetooth | grep -c \"Soft blocked: no\") -gt 0 ]] && echo true || echo false'";
        }
        {
          # Audio mute toggle
          label = "󰕾"; # nf-md-volume_high
          type = "toggle";
          active = true;
          command = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          update-command = "sh -c 'pactl get-sink-mute @DEFAULT_SINK@ | grep -q no && echo true || echo false'";
        }
        {
          # Microphone mute toggle
          label = "󰍬"; # nf-md-microphone
          type = "toggle";
          active = true;
          command = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          update-command = "sh -c 'pactl get-source-mute @DEFAULT_SOURCE@ | grep -q no && echo true || echo false'";
        }
        # {
        #   # System monitor (btop)
        #   label = "󰍛"; # nf-md-chart_areaspline
        #   command = "alacritty -e btop";
        # }
        {
          # Lock screen
          label = "󰌾"; # nf-md-lock
          command = "hyprlock";
        }
      ];
    };
  };
}
