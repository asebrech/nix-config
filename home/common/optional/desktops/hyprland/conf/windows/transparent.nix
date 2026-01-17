# Transparent windows
# More transparency for aesthetics
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 8;
      gaps_out = 16;
      border_size = 2;
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };

    group = {
      groupbar = {
        font_size = 12;
        font_family = "monospace";
        font_weight_active = "ultraheavy";
        font_weight_inactive = "normal";

        indicator_height = 0;
        indicator_gap = 5;
        height = 22;
        gaps_in = 5;
        gaps_out = 0;

        gradients = true;
        gradient_rounding = 0;
        gradient_round_only_edges = false;
      };
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
      force_split = 2;
    };

    master = {
      new_status = "master";
    };
  };
}
