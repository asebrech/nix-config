# ML4W keybindings adapted for NixOS
# Based on: https://github.com/mylinuxforwork/dotfiles
# Adapted for vicinae launcher
{ pkgs, ... }:

let
  mainMod = "SUPER";
in
{
  # Core applications
  "${mainMod}, RETURN" = "exec, ${pkgs.alacritty}/bin/alacritty";
  "${mainMod}, B" = "exec, firefox";
  "${mainMod}, E" = "exec, thunar";

  # Application launcher (vicinae instead of rofi)
  "${mainMod}, SPACE" = "exec, vicinae toggle"; # Main launcher
  "${mainMod}, TAB" = "exec, vicinae toggle vicinae://windows"; # Window switcher
  ", XF86Calculator" = "exec, vicinae toggle vicinae://extensions/vicinae/calculator"; # Calculator

  # Window management
  "${mainMod}, Q" = "killactive";
  "${mainMod}, F" = "fullscreen, 0"; # Fullscreen
  "${mainMod}, M" = "fullscreen, 1"; # Maximize
  "${mainMod}, T" = "togglefloating";
  "${mainMod} SHIFT, T" = "workspaceopt, allfloat"; # Toggle all floating
  "${mainMod}, P" = "pseudo"; # dwindle
  "${mainMod}, J" = "togglesplit"; # dwindle
  "${mainMod}, G" = "togglegroup"; # Toggle window group
  "${mainMod}, K" = "swapsplit"; # Swap split

  # Move focus with mainMod + arrow keys
  "${mainMod}, left" = "movefocus, l";
  "${mainMod}, right" = "movefocus, r";
  "${mainMod}, up" = "movefocus, u";
  "${mainMod}, down" = "movefocus, d";

  # Move windows with mainMod + ALT + arrow keys (changed from SHIFT to avoid conflict)
  "${mainMod} ALT, left" = "movewindow, l";
  "${mainMod} ALT, right" = "movewindow, r";
  "${mainMod} ALT, up" = "movewindow, u";
  "${mainMod} ALT, down" = "movewindow, d";

  # Swap windows with mainMod + CTRL + arrow keys
  "${mainMod} CTRL, left" = "swapwindow, l";
  "${mainMod} CTRL, right" = "swapwindow, r";
  "${mainMod} CTRL, up" = "swapwindow, u";
  "${mainMod} CTRL, down" = "swapwindow, d";

  # Resize windows with mainMod + SHIFT + arrow keys
  "${mainMod} SHIFT, right" = "resizeactive, 100 0";
  "${mainMod} SHIFT, left" = "resizeactive, -100 0";
  "${mainMod} SHIFT, up" = "resizeactive, 0 -100";
  "${mainMod} SHIFT, down" = "resizeactive, 0 100";

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

  # Navigate workspaces
  "${mainMod}, TAB" = "workspace, m+1"; # Next workspace
  "${mainMod} SHIFT, TAB" = "workspace, m-1"; # Previous workspace
  "${mainMod}, mouse_down" = "workspace, e+1";
  "${mainMod}, mouse_up" = "workspace, e-1";
  "${mainMod} CTRL, down" = "workspace, empty"; # Next empty workspace

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

  # Special workspace (scratchpad)
  "${mainMod}, S" = "togglespecialworkspace, magic";
  "${mainMod} SHIFT, S" = "movetoworkspace, special:magic";

  # Screenshot with grimblast
  "${mainMod}, Print" = "exec, ${pkgs.unstable.grimblast}/bin/grimblast copy area";
  "${mainMod} ALT, F" = "exec, ${pkgs.unstable.grimblast}/bin/grimblast copy output"; # Instant fullscreen
  "${mainMod} ALT, S" = "exec, ${pkgs.unstable.grimblast}/bin/grimblast copy area"; # Instant area

  # Lock screen
  "${mainMod} CTRL, L" = "exec, hyprlock";

  # Clipboard manager
  "${mainMod}, V" = "exec, copyq toggle";

  # System controls
  "${mainMod} CTRL, Q" = "exec, wlogout"; # Power menu
  "${mainMod} CTRL, R" = "exec, hyprctl reload"; # Reload Hyprland

  # Waybar
  "${mainMod} SHIFT, B" = "exec, killall waybar && waybar &"; # Reload waybar

  # Volume controls (function keys)
  ", XF86AudioRaiseVolume" = "exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
  ", XF86AudioLowerVolume" = "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
  ", XF86AudioMute" = "exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

  # Brightness controls
  ", XF86MonBrightnessUp" = "exec, brightnessctl -q s +10%";
  ", XF86MonBrightnessDown" = "exec, brightnessctl -q s 10%-";

  # Media controls
  ", XF86AudioPlay" = "exec, playerctl play-pause";
  ", XF86AudioPause" = "exec, playerctl pause";
  ", XF86AudioNext" = "exec, playerctl next";
  ", XF86AudioPrev" = "exec, playerctl previous";

  # Lock on lid close
  ", XF86Lock" = "exec, hyprlock";
}
