# Window rules configuration
# Adapted from ML4W dotfiles: default52.conf
# https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Window rules
    windowrule = [
      # Float specific windows
      "float, title:^(pavucontrol)$"
      "float, title:^(blueman-manager)$"
      "float, title:^(nm-connection-editor)$"
      "float, title:^(qalculate-gtk)$"

      # Browser Picture in Picture
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
      "move 69.5% 4%, title:^(Picture-in-Picture)$"

      # Idle inhibit for fullscreen windows
      "idleinhibit fullscreen, class:^(.*)$"

      # Xwayland related rules
      # When moving objects in resolve a large border is produced
      # This rule prevents that and serves as a template for any problematic xwayland apps
      "noblur, class:^(resolve)$, xwayland:1"

      # General xwayland rule (disabled by default as it can impact some apps like Emacs)
      # Uncomment if needed for xwayland app triage:
      # "noblur, xwayland:1"
    ];

    # Layer rules
    layerrule = [
      # Waybar blur
      "blur, waybar"
      "ignorealpha 0.01, waybar" # Forces blur on very transparent areas
      "ignorezero, waybar"

      # Vicinae launcher (Hyprland 0.53+ named rule syntax)
      "blur, namespace:vicinae"
      "ignorealpha 0, namespace:vicinae"
      "noanim, namespace:vicinae"
    ];
  };
}
