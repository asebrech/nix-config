# ML4W keybindings adapted for NixOS
# Based on: https://github.com/mylinuxforwork/dotfiles
{ pkgs, ... }:

let
  mainMod = "SUPER";
in
{
  # Core applications
  "${mainMod}, RETURN" = "exec, ${pkgs.alacritty}/bin/alacritty";
  "${mainMod}, B" = "exec, firefox";
  "${mainMod}, E" = "exec, thunar";

  # Window management
  "${mainMod}, Q" = "killactive";
  "${mainMod}, F" = "fullscreen";
  "${mainMod}, T" = "togglefloating";
  "${mainMod}, P" = "pseudo"; # dwindle
  "${mainMod}, J" = "togglesplit"; # dwindle

  # Move focus with mainMod + arrow keys
  "${mainMod}, left" = "movefocus, l";
  "${mainMod}, right" = "movefocus, r";
  "${mainMod}, up" = "movefocus, u";
  "${mainMod}, down" = "movefocus, d";

  # Move focus with mainMod + hjkl (vim keys)
  "${mainMod}, h" = "movefocus, l";
  "${mainMod}, l" = "movefocus, r";
  "${mainMod}, k" = "movefocus, u";
  "${mainMod}, j" = "movefocus, d";

  # Move windows with mainMod + SHIFT + arrow keys
  "${mainMod} SHIFT, left" = "movewindow, l";
  "${mainMod} SHIFT, right" = "movewindow, r";
  "${mainMod} SHIFT, up" = "movewindow, u";
  "${mainMod} SHIFT, down" = "movewindow, d";

  # Move windows with mainMod + SHIFT + hjkl
  "${mainMod} SHIFT, h" = "movewindow, l";
  "${mainMod} SHIFT, l" = "movewindow, r";
  "${mainMod} SHIFT, k" = "movewindow, u";
  "${mainMod} SHIFT, j" = "movewindow, d";

  # Resize windows with mainMod + CTRL + arrow keys
  "${mainMod} CTRL, left" = "resizeactive, -50 0";
  "${mainMod} CTRL, right" = "resizeactive, 50 0";
  "${mainMod} CTRL, up" = "resizeactive, 0 -50";
  "${mainMod} CTRL, down" = "resizeactive, 0 50";

  # Resize with mainMod + CTRL + hjkl
  "${mainMod} CTRL, h" = "resizeactive, -50 0";
  "${mainMod} CTRL, l" = "resizeactive, 50 0";
  "${mainMod} CTRL, k" = "resizeactive, 0 -50";
  "${mainMod} CTRL, j" = "resizeactive, 0 50";

  # Switch workspaces with mainMod + [0-9]
  "${mainMod}, 1" = "workspace, 1";
  "${mainMod}, 2" = "workspace, 2";
  "${mainMod}, 3" = "workspace, 3";
  "${mainMod}, 4" = "workspace, 4";
  "${mainMod}, 5" = "workspace, 5";
  "${mainMod}, 6" = "workspace, 6";
  "${mainMod}, 7" = "workspace, 7";
  "${mainMod}, 8" = "workspace, 8";
  "${mainMod}, 9" = "workspace, 9";
  "${mainMod}, 0" = "workspace, 10";

  # Move active window to workspace with mainMod + SHIFT + [0-9]
  "${mainMod} SHIFT, 1" = "movetoworkspace, 1";
  "${mainMod} SHIFT, 2" = "movetoworkspace, 2";
  "${mainMod} SHIFT, 3" = "movetoworkspace, 3";
  "${mainMod} SHIFT, 4" = "movetoworkspace, 4";
  "${mainMod} SHIFT, 5" = "movetoworkspace, 5";
  "${mainMod} SHIFT, 6" = "movetoworkspace, 6";
  "${mainMod} SHIFT, 7" = "movetoworkspace, 7";
  "${mainMod} SHIFT, 8" = "movetoworkspace, 8";
  "${mainMod} SHIFT, 9" = "movetoworkspace, 9";
  "${mainMod} SHIFT, 0" = "movetoworkspace, 10";

  # Scroll through existing workspaces with mainMod + scroll
  "${mainMod}, mouse_down" = "workspace, e+1";
  "${mainMod}, mouse_up" = "workspace, e-1";

  # Special workspace (scratchpad)
  "${mainMod}, S" = "togglespecialworkspace, magic";
  "${mainMod} SHIFT, S" = "movetoworkspace, special:magic";

  # Screenshot with grimblast
  ", Print" = "exec, ${pkgs.unstable.grimblast}/bin/grimblast copy area";
  "${mainMod}, Print" = "exec, ${pkgs.unstable.grimblast}/bin/grimblast copy screen";
  "${mainMod} SHIFT, Print" = "exec, ${pkgs.unstable.grimblast}/bin/grimblast copy window";

  # Lock screen
  "${mainMod}, L" = "exec, hyprlock";

  # Clipboard manager
  "${mainMod}, V" = "exec, copyq toggle";

  # System controls
  "${mainMod} SHIFT, E" = "exec, wlogout";

  # Volume controls (function keys)
  ", XF86AudioRaiseVolume" = "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
  ", XF86AudioLowerVolume" = "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
  ", XF86AudioMute" = "exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

  # Brightness controls
  ", XF86MonBrightnessUp" = "exec, brightnessctl s +5%";
  ", XF86MonBrightnessDown" = "exec, brightnessctl s 5%-";

  # Media controls
  ", XF86AudioPlay" = "exec, playerctl play-pause";
  ", XF86AudioNext" = "exec, playerctl next";
  ", XF86AudioPrev" = "exec, playerctl previous";
}
