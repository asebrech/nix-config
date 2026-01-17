# Custom keybindings
# Override or extend the standard keybindings
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Add your custom keybindings here
      # Example:
      # "SUPER SHIFT, E, exec, thunar"
    ];

    binde = [
      # Add repeating keybindings here
    ];

    bindm = [
      # Add mouse bindings here
    ];
  };
}
