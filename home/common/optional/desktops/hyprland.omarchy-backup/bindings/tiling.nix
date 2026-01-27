{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Close windows
    bind = [
      "SUPER, W, killactive"
      "SUPER SHIFT, Q, killactive"

      # Control tiling
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
    ];

    # Resize bindings with repeat
    binde = [
      "CTRL SHIFT SUPER, H, resizeactive, -5 0"
      "CTRL SHIFT SUPER, J, resizeactive, 0 5"
      "CTRL SHIFT SUPER, K, resizeactive, 0 -5"
      "CTRL SHIFT SUPER, L, resizeactive, 5 0"
    ];

    # Mouse bindings
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
