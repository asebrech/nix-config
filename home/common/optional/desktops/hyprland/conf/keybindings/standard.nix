# Standard keybindings from ML4W
# Based on: https://github.com/mylinuxforwork/dotfiles
# Adapted for nix-config
{ osConfig, ... }:
let
  terminal = "alacritty";
  editor = osConfig.hostSpec.defaultEditor or "nvim";
in
{
  wayland.windowManager.hyprland.settings = {
    # Window management
    bind = [
      # Close windows
      "SUPER, W, killactive"
      "SUPER SHIFT, Q, killactive"

      # Window controls
      "SUPER, J, togglesplit"
      "SUPER, P, pseudo"
      "SUPER SHIFT, F, togglefloating"
      "SUPER, F, fullscreenstate, 2 -1"
      "SUPER SHIFT, P, pin"

      # Move focus with SUPER + arrow keys and hjkl
      "SUPER, LEFT, movefocus, l"
      "SUPER, RIGHT, movefocus, r"
      "SUPER, UP, movefocus, u"
      "SUPER, DOWN, movefocus, d"
      "SUPER, H, movefocus, l"
      "SUPER, L, movefocus, r"
      "SUPER, K, movefocus, u"

      # Switch workspaces with SUPER + [1-9; 0]
      "SUPER, code:10, workspace, 1"
      "SUPER, code:11, workspace, 2"
      "SUPER, code:12, workspace, 3"
      "SUPER, code:13, workspace, 4"
      "SUPER, code:14, workspace, 5"
      "SUPER, code:15, workspace, 6"
      "SUPER, code:16, workspace, 7"
      "SUPER, code:17, workspace, 8"
      "SUPER, code:18, workspace, 9"
      "SUPER, code:19, workspace, 10"

      # Move active window to a workspace with SUPER + SHIFT + [1-9; 0]
      "SUPER SHIFT, code:10, movetoworkspace, 1"
      "SUPER SHIFT, code:11, movetoworkspace, 2"
      "SUPER SHIFT, code:12, movetoworkspace, 3"
      "SUPER SHIFT, code:13, movetoworkspace, 4"
      "SUPER SHIFT, code:14, movetoworkspace, 5"
      "SUPER SHIFT, code:15, movetoworkspace, 6"
      "SUPER SHIFT, code:16, movetoworkspace, 7"
      "SUPER SHIFT, code:17, movetoworkspace, 8"
      "SUPER SHIFT, code:18, movetoworkspace, 9"
      "SUPER SHIFT, code:19, movetoworkspace, 10"

      # Scratchpad
      "SUPER, S, togglespecialworkspace, scratchpad"

      # TAB between workspaces
      "SUPER, TAB, workspace, e+1"
      "SUPER SHIFT, TAB, workspace, e-1"

      # Swap active window with SUPER + SHIFT + arrow keys
      "SUPER SHIFT, LEFT, swapwindow, l"
      "SUPER SHIFT, RIGHT, swapwindow, r"
      "SUPER SHIFT, UP, swapwindow, u"
      "SUPER SHIFT, DOWN, swapwindow, d"
      "SUPER SHIFT, H, swapwindow, l"
      "SUPER SHIFT, L, swapwindow, r"
      "SUPER SHIFT, K, swapwindow, u"
      "SUPER SHIFT, J, swapwindow, d"

      # Groups
      "SUPER, G, togglegroup"
      "SUPER, apostrophe, changegroupactive, f"
      "SUPER SHIFT, apostrophe, changegroupactive, b"

      # Application launchers
      "SUPER, SPACE, exec, rofi -show drun"
      "SUPER, Return, exec, ${terminal}"
      "CTRL SUPER, V, exec, ${terminal} ${editor}"
      "CTRL SUPER, F, exec, thunar"

      # Waybar toggle
      "SUPER SHIFT, B, exec, pkill waybar || waybar"

      # Transparency toggle
      "SUPER, BACKSPACE, exec, hyprctl dispatch setprop active opaque toggle"

      # Notifications (dunst)
      "SUPER, COMMA, exec, dunstctl close"
      "SUPER SHIFT, COMMA, exec, dunstctl close-all"
      "SUPER CTRL, COMMA, exec, dunstctl set-paused toggle"
      "SUPER ALT, COMMA, exec, dunstctl history-pop"

      # Screenshots (grimblast)
      "CTRL SUPER, P, exec, grimblast --notify --freeze copy area"
      ", PRINT, exec, grimblast --notify --freeze copy area"
      "SHIFT, PRINT, exec, grimblast --notify copy screen"
      "ALT, PRINT, exec, grimblast --notify save area"

      # Color picker
      "SUPER, PRINT, exec, pkill hyprpicker || hyprpicker -a"

      # System control
      "SUPER CTRL, L, exec, hyprlock"
      "SUPER SHIFT, R, exec, hyprctl reload"

      # Clipboard
      "SUPER, C, exec, wl-copy"
      "SUPER, V, exec, wl-paste"
    ];

    # Resize bindings with repeat
    binde = [
      "CTRL SHIFT SUPER, H, resizeactive, -5 0"
      "CTRL SHIFT SUPER, J, resizeactive, 0 5"
      "CTRL SHIFT SUPER, K, resizeactive, 0 -5"
      "CTRL SHIFT SUPER, L, resizeactive, 5 0"

      # Volume controls
      ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
      ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"

      # Brightness controls
      ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];

    # Media controls
    bind = [
      ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
      ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    # Mouse bindings
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
