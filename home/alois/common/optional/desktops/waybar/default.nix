# Mechabar - A mecha-themed Waybar configuration
# Adapted from https://github.com/sejjy/mechabar
# Nixified with Stylix integration for theming
{
  pkgs,
  ...
}:
let
  # Import all modules from the unified module index
  allModules = import ./modules;

  # Import custom styles
  customStyle = import ./styles;
in
{
  # Import scripts package
  imports = [
    ./scripts
  ];

  # Disable Stylix's addCss (which adds underlines on workspaces)
  # Keep colors and fonts enabled - we handle the rest in our CSS
  stylix.targets.waybar.addCss = false;

  # Let it try to start a few more times
  systemd.user.services.waybar = {
    Unit.StartLimitInterval = 0;
  };

  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
    systemd.enable = true;

    # Stylix provides @base00-@base0F color variables and font
    # We provide the full mechabar CSS styling

    settings = {
      mainBar = {
        # Layout configuration matching mechabar
        layer = "top";
        position = "top";
        height = 0;
        width = 0;
        margin = "0";
        spacing = 0;
        mode = "dock";
        reload_style_on_change = true;

        # Module layout - mechabar style with three sections
        modules-left = [
          "group/user"
          "custom/left_div#1"
          "hyprland/workspaces"
          "custom/right_div#1"
          "hyprland/window"
        ];

        modules-center = [
          "hyprland/windowcount"
          "custom/left_div#2"
          "temperature"
          "custom/left_div#3"
          "memory"
          "custom/left_div#4"
          "cpu"
          "custom/left_inv#1"
          "custom/left_div#5"
          "custom/distro"
          "custom/right_div#2"
          "custom/right_inv#1"
          "idle_inhibitor"
          "clock#time"
          "custom/right_div#3"
          "clock#date"
          "custom/right_div#4"
          "network"
          "bluetooth"
          "custom/system_update"
          "custom/right_div#5"
        ];

        modules-right = [
          "mpris"
          "custom/left_div#6"
          "group/pulseaudio"
          "custom/left_div#7"
          "backlight"
          "custom/left_div#8"
          "battery"
          "custom/left_inv#2"
          "custom/notifications"
        ];
      }
      // allModules;
    };

    # Custom CSS styling with Stylix color integration
    style = customStyle;
  };

  services.network-manager-applet.enable = true;

  # Required dependencies for mechabar scripts
  home.packages = with pkgs; [
    brightnessctl # Backlight control
  ];
}
