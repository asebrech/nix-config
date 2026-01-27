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
    persistent-workspaces = {
      "*" = 5;
    };
    on-scroll-up = "hyprctl dispatch workspace +1";
    on-scroll-down = "hyprctl dispatch workspace -1";
    cursor = true;
  };
}
