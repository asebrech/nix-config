# Hyprlock - Lock screen configuration
# Adapted from ML4W dotfiles: https://github.com/mylinuxforwork/dotfiles
# Colors handled by Stylix, layout and structure from ML4W
{
  config,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
      };

      # Note: background and input-field are configured by Stylix

      # Clock label (top right)
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$TIME"'';
          font_size = 70;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "-50, 20";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
        # User label (below clock)
        {
          monitor = "";
          text = "$USER";
          font_size = 20;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "-50, 120";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];

      # Profile image (centered above input)
      image = [
        {
          monitor = "";
          path = "${config.hostSpec.userAvatar}";
          size = 280;
          rounding = 40;
          border_size = 4;
          rotate = 0;
          reload_time = -1;
          position = "0, 200";
          halign = "center";
          valign = "center";
          shadow_passes = 10;
          shadow_size = 20;
          shadow_boost = 1.6;
        }
      ];
    };
  };
}
