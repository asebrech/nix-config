{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Volume and brightness controls using pactl and brightnessctl
    binde = [
      # Volume controls - Output
      ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
      ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      # Volume controls - Input
      ", XF86AudioRaiseVolume, exec, pactl set-source-volume @DEFAULT_SOURCE@ +5%"
      ", XF86AudioLowerVolume, exec, pactl set-source-volume @DEFAULT_SOURCE@ -5%"
      # Brightness controls
      ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];

    bind = [
      # Mute toggles
      ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
      ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"

      # Player controls
      ", XF86AudioPlay, exec, playerctl --ignore-player=firefox,chromium,brave play-pause"
      ", XF86AudioNext, exec, playerctl --ignore-player=firefox,chromium,brave next"
      ", XF86AudioPrev, exec, playerctl --ignore-player=firefox,chromium,brave previous"
    ];
  };
}
