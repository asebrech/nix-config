# Misc settings
# Adapted from ML4W dotfiles: https://github.com/mylinuxforwork/dotfiles
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      initial_workspace_tracking = 1;
      allow_session_lock_restore = true;
      focus_on_activate = true; # Focus window on vicinae activation
    };

    # Enable debug logging to capture config errors and issues
    # Helps diagnose problems with monitor configuration and lid events
    debug = {
      disable_logs = false; # Enable logging for better error messages
    };
  };
}
