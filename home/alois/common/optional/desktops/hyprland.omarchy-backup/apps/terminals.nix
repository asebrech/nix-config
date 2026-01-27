{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Define terminal tag to style them uniformly
    windowrulev2 = [
      "tag +terminal, class:(Alacritty)"
    ];
  };
}
