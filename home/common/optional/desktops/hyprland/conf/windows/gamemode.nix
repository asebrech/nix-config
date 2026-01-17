# Gaming window optimizations
# No gaps, minimal borders for maximum screen space
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 0;
      gaps_out = 0;
      border_size = 1;
      resize_on_border = false;
      allow_tearing = true;
      layout = "dwindle";
    };

    group = {
      groupbar = {
        font_size = 12;
        font_family = "monospace";
        font_weight_active = "ultraheavy";
        font_weight_inactive = "normal";

        indicator_height = 0;
        indicator_gap = 0;
        height = 18;
        gaps_in = 0;
        gaps_out = 0;

        gradients = false;
        gradient_rounding = 0;
        gradient_round_only_edges = false;
      };
    };

    dwindle = {
      pseudotile = false;
      preserve_split = true;
      force_split = 2;
    };

    master = {
      new_status = "master";
    };
  };
}
