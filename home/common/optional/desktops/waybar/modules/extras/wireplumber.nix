# Extras module: Wireplumber (alternative to PulseAudio)
# Adapted from mechabar: modules/extras/wireplumber.jsonc
{
  wireplumber = {
    format = "{icon} {volume}%";
    format-muted = "󰝟";
    format-icons = [
      "󰕿"
      "󰖀"
      "󰕾"
    ];
    min-length = 7;
    max-length = 7;
    scroll-step = 1;
    on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    tooltip-format = "{node_name}";
  };
}
