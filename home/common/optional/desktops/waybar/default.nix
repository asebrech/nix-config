{ pkgs, ... }:
let
  modules = import ./modules.nix { inherit pkgs; };
in
{
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  # Let it try to start a few more times
  systemd.user.services.waybar = {
    Unit.StartLimitInterval = 0;
  };

  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
    systemd = {
      enable = true;
    };

    # Main configuration based on ML4W minimal theme
    settings = {
      mainBar = {
        # General Settings
        layer = "top";
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        spacing = 0;
        height = 52;

        # Modules Layout (ML4W minimal theme)
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "pulseaudio"
          "bluetooth"
          "network"
          "battery"
          "power-profiles-daemon"
          "group/hardware"
          "tray"
        ];

        # Module definitions from modules.nix
        "hyprland/workspaces" = modules."hyprland/workspaces";
        "wlr/taskbar" = modules."wlr/taskbar";
        "hyprland/window" = modules."hyprland/window";
        "custom/cliphist" = modules."custom/cliphist";
        tray = modules.tray;
        clock = modules.clock;
        cpu = modules.cpu;
        memory = modules.memory;
        disk = modules.disk;
        "hyprland/language" = modules."hyprland/language";
        "group/hardware" = modules."group/hardware";
        network = modules.network;
        battery = modules.battery;
        "power-profiles-daemon" = modules."power-profiles-daemon";
        pulseaudio = modules.pulseaudio;
        bluetooth = modules.bluetooth;
        backlight = modules.backlight;
      };
    };
  };
}
