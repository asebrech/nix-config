{ osConfig, ... }:
let
  terminal = "alacritty";
  editor = osConfig.hostSpec.defaultEditor or "nvim";
in
{
  wayland.windowManager.hyprland.settings = {
    # Application launchers and menus
    bind = [
      "SUPER, SPACE, exec, vicinae toggle"
      "SUPER, TAB, exec, vicinae toggle vicinae://windows"
      ", XF86Calculator, exec, vicinae toggle vicinae://extensions/vicinae/calculator"

      # Terminal and common apps
      "SUPER, Return, exec, ${terminal}"
      "CTRL SUPER, V, exec, ${terminal} ${editor}"
      "CTRL SUPER, F, exec, thunar"

      # Waybar toggle
      "SUPER SHIFT, B, exec, pkill waybar || waybar"

      # Window management
      "SUPER, X, togglesplit"
      "SUPER, minus, focuscurrentorlast"
      "SUPER SHIFT, minus, focusurgentorlast"

      # Window transparency toggle
      "SUPER, BACKSPACE, exec, hyprctl dispatch setprop \"address:$(hyprctl activewindow -j | jq -r '.address')\" opaque toggle"

      # Notifications (using dunst)
      "SUPER, COMMA, exec, dunstctl close"
      "SUPER SHIFT, COMMA, exec, dunstctl close-all"
      "SUPER CTRL, COMMA, exec, dunstctl set-paused toggle"
      "SUPER ALT, COMMA, exec, dunstctl history-pop"

      # Screenshots using grimblast
      "CTRL SUPER, P, exec, grimblast --notify --freeze copy area"
      ", PRINT, exec, grimblast --notify --freeze copy area"
      "SHIFT, PRINT, exec, grimblast --notify copy screen"
      "ALT, PRINT, exec, grimblast --notify save area"

      # Color picker
      "SUPER, PRINT, exec, pkill hyprpicker || hyprpicker -a"

      # System information
      "SUPER CTRL ALT, T, exec, notify-send \"$(date +\"%A %H:%M — %d %B %Y\")\""

      # System control
      "SUPER CTRL, L, exec, hyprlock"
      "SUPER SHIFT, R, exec, hyprctl reload"
    ];
  };
}
