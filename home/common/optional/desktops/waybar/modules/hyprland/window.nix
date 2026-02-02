# Hyprland module: Window title
# Adapted from mechabar: modules/hyprland/window.jsonc
{
  "hyprland/window" = {
    format = "{}";
    rewrite = {
      "" = "Desktop";
      "foot" = "Terminal";
      "alacritty" = "Terminal";
      "kitty" = "Terminal";
      "zsh" = "Terminal";
      "~" = "Terminal";
    };
    swap-icon-label = false;
  };
}
