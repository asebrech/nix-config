# Keyboard and input device configuration
# Adapted from ML4W dotfiles: https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us";
      kb_variant = "";
      kb_model = "";
      kb_options = "";
      numlock_by_default = true;
      follow_mouse = 1;
      mouse_refocus = false;

      touchpad = {
        natural_scroll = false;
        scroll_factor = 1.0; # Touchpad scroll factor
        disable_while_typing = false;
        clickfinger_behavior = true; # Two-finger tap/click for right-click, three-finger for middle-click
        tap-to-click = true; # Enable tap-to-click
      };

      sensitivity = 0; # Pointer speed: -1.0 - 1.0, 0 means no modification
    };
  };
}
