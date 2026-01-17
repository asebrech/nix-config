# ML4W keybindings - EXACT copy from ML4W dotfiles
# Based on: https://github.com/mylinuxforwork/dotfiles
# Only change: launcher.sh replaced with vicinae
{ pkgs, ... }:

let
  mainMod = "SUPER";
in
{
  # Applications
  "${mainMod}, RETURN" = "exec, ${pkgs.alacritty}/bin/alacritty";
  "${mainMod}, B" = "exec, firefox";
  "${mainMod}, E" = "exec, thunar";

  # Windows
  "${mainMod}, Q" = "killactive";
  "${mainMod} SHIFT, Q" = "exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill";
  "${mainMod}, F" = "fullscreen, 0";
  "${mainMod}, M" = "fullscreen, 1";
  "${mainMod}, T" = "togglefloating";
  "${mainMod} SHIFT, T" = "workspaceopt, allfloat";
  "${mainMod}, J" = "togglesplit";
  "${mainMod}, left" = "movefocus, l";
  "${mainMod}, right" = "movefocus, r";
  "${mainMod}, up" = "movefocus, u";
  "${mainMod}, down" = "movefocus, d";
  "${mainMod} SHIFT, right" = "resizeactive, 100 0";
  "${mainMod} SHIFT, left" = "resizeactive, -100 0";
  "${mainMod} SHIFT, down" = "resizeactive, 0 100";
  "${mainMod} SHIFT, up" = "resizeactive, 0 -100";
  "${mainMod}, G" = "togglegroup";
  "${mainMod}, K" = "swapsplit";
  "${mainMod} ALT, left" = "swapwindow, l";
  "${mainMod} ALT, right" = "swapwindow, r";
  "${mainMod} ALT, up" = "swapwindow, u";
  "${mainMod} ALT, down" = "swapwindow, d";
  "ALT, Tab" = "cyclenext";

  # Actions
  "${mainMod} CTRL, R" = "exec, hyprctl reload";
  "${mainMod}, PRINT" = "exec, ${pkgs.unstable.grimblast}/bin/grimblast copy area";
  "${mainMod} ALT, F" = "exec, ${pkgs.unstable.grimblast}/bin/grimblast copy output";
  "${mainMod} ALT, S" = "exec, ${pkgs.unstable.grimblast}/bin/grimblast copy area";
  "${mainMod} CTRL, Q" = "exec, wlogout";
  "${mainMod} CTRL, RETURN" = "exec, vicinae toggle"; # ONLY CHANGE: launcher.sh → vicinae
  "${mainMod} SHIFT, B" = "exec, killall waybar && waybar &";
  "${mainMod} CTRL, B" = "exec, killall -SIGUSR1 waybar";
  "${mainMod}, V" = "exec, copyq toggle";
  "${mainMod} CTRL, L" = "exec, hyprlock";

  # Workspaces
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
  "${mainMod}, Tab" = "workspace, m+1";
  "${mainMod} SHIFT, Tab" = "workspace, m-1";
  "${mainMod}, mouse_down" = "workspace, e+1";
  "${mainMod}, mouse_up" = "workspace, e-1";
  "${mainMod} CTRL, down" = "workspace, empty";

  # Fn keys
  ", XF86MonBrightnessUp" = "exec, brightnessctl -q s +10%";
  ", XF86MonBrightnessDown" = "exec, brightnessctl -q s 10%-";
  ", XF86AudioRaiseVolume" = "exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
  ", XF86AudioLowerVolume" = "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
  ", XF86AudioMute" = "exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
  ", XF86AudioPlay" = "exec, playerctl play-pause";
  ", XF86AudioPause" = "exec, playerctl pause";
  ", XF86AudioNext" = "exec, playerctl next";
  ", XF86AudioPrev" = "exec, playerctl previous";
  ", XF86Lock" = "exec, hyprlock";
}
