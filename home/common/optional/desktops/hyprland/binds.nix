{
  osConfig,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    # Reference of supported bind flags: https://wiki.hyprland.org/Configuring/Binds/#bind-flags

    #
    # ========== Mouse Binds ==========
    #
    bindm = [
      # hold SUPER + leftlclick  to move/drag active window
      "SUPER,mouse:272,movewindow" # NOTE: movewindoworgroup is not available for mouse
      # hold SUPER + rightclick to resize active window
      "SUPER,mouse:273,resizewindow"
    ];

    #
    # ========== Non-consuming Binds ==========
    #
    bindn = [
    ];

    #
    # ========== Repeat Binds ==========
    #
    binde = [
      # Resize active window 5 pixels in direction
      "Control_L&Shift_L&SUPER, h, resizeactive, -5 0"
      "Control_L&Shift_L&SUPER, j, resizeactive, 0 5"
      "Control_L&Shift_L&SUPER, k, resizeactive, 0 -5"
      "Control_L&Shift_L&SUPER, l, resizeactive, 5 0"

      # Volume - Output
      ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
      ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      # Volume - Input
      ", XF86AudioRaiseVolume, exec, pactl set-source-volume @DEFAULT_SOURCE@ +5%"
      ", XF86AudioLowerVolume, exec, pactl set-source-volume @DEFAULT_SOURCE@ -5%"
    ];

    #
    # ========== One-shot Binds ==========
    #
    bind =
      let
        workspaces = [
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
          "8"
          "9"
          "10"
          "F1"
          "F2"
          "F3"
          "F4"
          "F5"
          "F6"
          "F7"
          "F8"
          "F9"
          "F10"
          "F11"
          "F12"
        ];
        # Map keys (arrows and hjkl) to hyprland directions (l, r, u, d)
        directions = rec {
          left = "l";
          right = "r";
          up = "u";
          down = "d";
          h = left;
          l = right;
          k = up;
          j = down;
        };
        terminal = "alacritty";
        editor = osConfig.hostSpec.defaultEditor or "nvim";

      in
      lib.flatten [

        #
        # ========== Quick Launch ==========
        #
        "SUPER,space,exec,rofi -show drun"
        "SHIFT_SUPER,space,exec,rofi -show run"
        "SUPER,s,exec,rofi -show ssh"
        "SUPER,tab,exec,rofi -show window"

        "SUPER,Return,exec,${terminal}"
        "CTRL_SUPER,v,exec,${terminal} ${editor}"
        "CTRL_SUPER,f,exec,thunar"

        #
        # ========== Screenshotting ==========
        #
        "CTRL_SUPER,p,exec,grimblast --notify --freeze copy area"
        ",Print,exec,grimblast --notify --freeze copy area"

        #
        # ========== Media Controls ==========
        #
        # see "binde" above for volume ctrls that need repeat binding
        # Output
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        # Input
        ", XF86AudioMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        # Player
        ", XF86AudioPlay, exec, playerctl --ignore-player=firefox,chromium,brave play-pause"
        ", XF86AudioNext, exec, playerctl --ignore-player=firefox,chromium,brave next"
        ", XF86AudioPrev, exec, playerctl --ignore-player=firefox,chromium,brave previous"

        #
        # ========== Windows and Groups ==========
        #
        #NOTE: window resizing is under "Repeat Binds" above

        # Focuses the urgent window or the last window
        "SHIFTSUPER,minus,focusurgentorlast"
        #Switch focus from current to previously focused window
        "SUPER,minus,focuscurrentorlast"

        # Close the focused/active window
        "SHIFTSUPER,q,killactive"

        # Fullscreen
        "SUPER,f,fullscreenstate,2 -1" # `internal client`, where `internal` and `client` can be -1 - current, 0 - none, 1 - maximize, 2 - fullscreen, 3 - maximize and fullscreen
        # Float
        "SHIFTSUPER,F,togglefloating"
        # Pin Active Floating window
        "SHIFTSUPER,p, pin, active" # pins a floating window (i.e. show it on all workspaces)

        # Splits
        "SUPER,x,togglesplit"

        # Tab groups
        "SUPER,g,togglegroup" # toggle the current active window into a group
        "SUPER,apostrophe,changegroupactive,f"
        "SHIFTSUPER,apostrophe,changegroupactive,b"

        #
        # ========== Workspaces ==========
        #
        # Switch workspace
        (map (ws: "SUPER,${ws},workspace,${ws}") workspaces)
        # Move active window to workspace
        (map (ws: "SHIFTSUPER,${ws},movetoworkspace,${ws}") workspaces)

        # Move focus with arrow keys
        (lib.mapAttrsToList (key: direction: "SUPER,${key},movefocus,${direction}") directions)
        # Move window with arrow keys
        (lib.mapAttrsToList (key: direction: "SHIFTSUPER,${key},movewindoworgroup,${direction}") directions)
        # Swap window with arrow keys
        (lib.mapAttrsToList (key: direction: "CTRLSUPER,${key},swapwindow,${direction}") directions)
        # Move workspace to monitor in specified direction
        (lib.mapAttrsToList (
          key: direction: "CTRLSHIFT,${key},movecurrentworkspacetomonitor,${direction}"
        ) directions)

        #
        # ========== Monitors ==========
        #
        "SUPER, m, exec, toggleMonitors" # toggle all monitors on/off. custom function in ./scripts.nix
        "SUPER, n, exec, toggleMonitorsNonPrimary" # toggle on/off all but center monitor. custom function in ./scripts.nix

        #
        # ========== Misc ==========
        #
        "SHIFTSUPER, t, exec, arrangeTiles" # custom function in ./scripts.nix
        "SHIFTSUPER,r,exec,hyprctl reload" # reload the configuration file
        "SUPER,e,exec,wlogout" # display wlogout
      ];
  };
}
