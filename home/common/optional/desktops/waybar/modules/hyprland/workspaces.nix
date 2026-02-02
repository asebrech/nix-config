# Hyprland module: Workspaces
# Adapted from mechabar: modules/hyprland/workspaces.jsonc
let
  # Mechabar style icons
  # Active = Diamond (filled)
  # Default/Empty = Dot
  # U+25C6 = Black Diamond (filled)
  # U+2022 = Bullet (dot)
  diamondFill = builtins.fromJSON ''"\u25c6"'';
  dot = builtins.fromJSON ''"\u2022"'';
in
{
  "hyprland/workspaces" = {
    format = "{icon}";
    format-icons = {
      active = diamondFill;
      default = dot;
    };
    # Show first 5 workspaces persistently
    # Use all-outputs to show all workspaces on all monitors (shared workspace view)
    persistent-workspaces = {
      "1" = [ ];
      "2" = [ ];
      "3" = [ ];
      "4" = [ ];
      "5" = [ ];
    };
    all-outputs = true; # Show all workspaces on all monitors (not per-monitor)
    on-scroll-up = "hyprctl dispatch workspace +1";
    on-scroll-down = "hyprctl dispatch workspace -1";
    cursor = true;
  };
}
