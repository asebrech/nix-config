# Keybindings configuration
# Adapted from ML4W dotfiles: default.conf
# https://github.com/mylinuxforwork/dotfiles
{ pkgs, ... }:
let
  mainMod = "SUPER";
in
{
  wayland.windowManager.hyprland.settings = {
    # Main modifier key
    "$mainMod" = mainMod;

    # Keybindings
    bind = [
      # Applications
      "${mainMod}, RETURN, exec, alacritty" # Open terminal (alacritty)
      "${mainMod}, B, exec, brave" # Open browser
      "${mainMod}, E, exec, thunar" # Open file manager
      "${mainMod} CTRL, C, exec, galculator" # Open calculator

      # Launcher
      "${mainMod} CTRL, RETURN, exec, vicinae toggle" # Open application launcher
      "${mainMod}, SPACE, exec, vicinae toggle" # Open application launcher (alternative)

      # Windows
      "${mainMod}, Q, killactive" # Kill active window
      "${mainMod}, F, fullscreen, 0" # Set active window to fullscreen
      "${mainMod}, M, fullscreen, 1" # Maximize window
      "${mainMod}, T, togglefloating" # Toggle floating mode
      "${mainMod} SHIFT, T, workspaceopt, allfloat" # Toggle all windows floating
      "${mainMod}, J, togglesplit" # Toggle split
      "${mainMod}, P, pseudo" # Pseudo tiling

      # Focus
      "${mainMod}, left, movefocus, l" # Move focus left
      "${mainMod}, right, movefocus, r" # Move focus right
      "${mainMod}, up, movefocus, u" # Move focus up
      "${mainMod}, down, movefocus, d" # Move focus down

      # Resize window with keyboard
      "${mainMod} SHIFT, right, resizeactive, 100 0" # Increase width
      "${mainMod} SHIFT, left, resizeactive, -100 0" # Decrease width
      "${mainMod} SHIFT, down, resizeactive, 0 100" # Increase height
      "${mainMod} SHIFT, up, resizeactive, 0 -100" # Decrease height

      # Window groups
      "${mainMod}, G, togglegroup" # Toggle window group
      "${mainMod}, K, swapsplit" # Swap split

      # Swap tiled windows
      "${mainMod} ALT, left, swapwindow, l" # Swap left
      "${mainMod} ALT, right, swapwindow, r" # Swap right
      "${mainMod} ALT, up, swapwindow, u" # Swap up
      "${mainMod} ALT, down, swapwindow, d" # Swap down

      # Screenshot
      "${mainMod}, PRINT, exec, ${pkgs.unstable.grimblast}/bin/grimblast --notify copy area" # Screenshot area
      "${mainMod} ALT, F, exec, ${pkgs.unstable.grimblast}/bin/grimblast --notify copy screen" # Screenshot fullscreen
      "${mainMod} ALT, S, exec, ${pkgs.unstable.grimblast}/bin/grimblast --notify copy area" # Screenshot area (alt)

      # Hyprland actions
      "${mainMod} CTRL, R, exec, hyprctl reload" # Reload Hyprland

      # Waybar
      "${mainMod} CTRL, B, exec, pkill waybar || waybar" # Toggle Waybar
      "${mainMod} SHIFT, B, exec, pkill waybar; waybar" # Reload Waybar

      # Clipboard
      "${mainMod}, V, exec, vicinae clipboard" # Open clipboard manager

      # Workspaces (1-10)
      "${mainMod}, 1, workspace, 1"
      "${mainMod}, 2, workspace, 2"
      "${mainMod}, 3, workspace, 3"
      "${mainMod}, 4, workspace, 4"
      "${mainMod}, 5, workspace, 5"
      "${mainMod}, 6, workspace, 6"
      "${mainMod}, 7, workspace, 7"
      "${mainMod}, 8, workspace, 8"
      "${mainMod}, 9, workspace, 9"
      "${mainMod}, 0, workspace, 10"

      # Move active window to workspace (1-10)
      "${mainMod} SHIFT, 1, movetoworkspace, 1"
      "${mainMod} SHIFT, 2, movetoworkspace, 2"
      "${mainMod} SHIFT, 3, movetoworkspace, 3"
      "${mainMod} SHIFT, 4, movetoworkspace, 4"
      "${mainMod} SHIFT, 5, movetoworkspace, 5"
      "${mainMod} SHIFT, 6, movetoworkspace, 6"
      "${mainMod} SHIFT, 7, movetoworkspace, 7"
      "${mainMod} SHIFT, 8, movetoworkspace, 8"
      "${mainMod} SHIFT, 9, movetoworkspace, 9"
      "${mainMod} SHIFT, 0, movetoworkspace, 10"

      # Move ALL windows to workspace (1-10)
      "${mainMod} CTRL, 1, movetoworkspacesilent, 1"
      "${mainMod} CTRL, 2, movetoworkspacesilent, 2"
      "${mainMod} CTRL, 3, movetoworkspacesilent, 3"
      "${mainMod} CTRL, 4, movetoworkspacesilent, 4"
      "${mainMod} CTRL, 5, movetoworkspacesilent, 5"
      "${mainMod} CTRL, 6, movetoworkspacesilent, 6"
      "${mainMod} CTRL, 7, movetoworkspacesilent, 7"
      "${mainMod} CTRL, 8, movetoworkspacesilent, 8"
      "${mainMod} CTRL, 9, movetoworkspacesilent, 9"
      "${mainMod} CTRL, 0, movetoworkspacesilent, 10"

      # Workspace navigation
      "${mainMod}, Tab, workspace, m+1" # Next workspace
      "${mainMod} SHIFT, Tab, workspace, m-1" # Previous workspace
      "${mainMod}, mouse_down, workspace, e+1" # Next workspace (mouse)
      "${mainMod}, mouse_up, workspace, e-1" # Previous workspace (mouse)
      "${mainMod} CTRL, down, workspace, empty" # Next empty workspace

      # Function keys
      ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -q s +10%" # Brightness up
      ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -q s 10%-" # Brightness down
      ", XF86AudioMute, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle" # Mute
      ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause" # Play/pause
      ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl pause" # Pause
      ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next" # Next track
      ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous" # Previous track
      ", XF86AudioMicMute, exec, ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle" # Toggle microphone
      ", XF86Calculator, exec, galculator" # Open calculator
      ", XF86Lock, exec, hyprlock" # Lock screen
    ];

    # Hold to repeat bindings
    bindle = [
      ", XF86AudioRaiseVolume, exec, ${pkgs.pulseaudio}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" # Volume up
      ", XF86AudioLowerVolume, exec, ${pkgs.pulseaudio}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" # Volume down
    ];

    # Repeat bindings
    binde = [
      "ALT, Tab, cyclenext" # Cycle windows
      "ALT, Tab, bringactivetotop" # Bring active to top
    ];

    # Mouse bindings
    bindm = [
      "${mainMod}, mouse:272, movewindow" # Move window with mouse
      "${mainMod}, mouse:273, resizewindow" # Resize window with mouse
    ];
  };
}
