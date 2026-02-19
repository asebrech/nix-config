{ config, ... }:
{
  imports = [
    #
    # ========== Required Configs ==========
    #
    common/core

    #
    # ========== Host-specific Optional Configs ==========
    #
    common/optional/browsers
    common/optional/comms
    common/optional/desktops
    common/optional/media
    common/optional/reverse-engineering.nix
    common/optional/tools
    common/optional/zellij
    common/optional/opencode.nix

    common/optional/sops.nix

    #
    # ========== Asahi-Specific: Dynamic Monitor Management ==========
    #
    # Asahi needs hyprdynamicmonitors for handling HDMI hotplug and lid events
    # Other hosts use static monitor config from hyprland/conf/monitors.nix
    common/optional/desktops/hyprdynamicmonitors.nix
  ];

  # Systemd service for lid event handling
  # Monitors UPower DBus for lid close/open events and executes custom scripts
  # Scripts are defined in common/optional/desktops/hyprdynamicmonitors.nix
  systemd.user.services.lid-handler = {
    Unit = {
      Description = "Custom lid close/open handler via UPower DBus";
      Documentation = "https://github.com/AsahiLinux/linux/issues/430";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      # The lid monitor script is provided by hyprdynamicmonitors.nix
      # and exposed via LID_MONITOR_SCRIPT session variable
      ExecStart = config.home.sessionVariables.LID_MONITOR_SCRIPT;
      Restart = "always";
      RestartSec = 3;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Override hypridle for Asahi: disable suspend, add aggressive power saving
  # HDMI hotplug detection is broken after suspend on Asahi Linux
  # See: https://github.com/AsahiLinux/linux/issues/430
  services.hypridle.settings.listener = [
    # Dim monitor backlight aggressively to save power
    {
      timeout = 300; # 5min
      on-timeout = "brightnessctl -s set 5%"; # More aggressive: 5% instead of 10%
      on-resume = "brightnessctl -r";
    }
    # Lock screen
    {
      timeout = 600; # 10min
      on-timeout = "loginctl lock-session";
    }
    # Turn off display
    {
      timeout = 660; # 11min
      on-timeout = "hyprctl dispatch dpms off";
      on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
    }
    # Completely dim display after extended idle (saves more power)
    {
      timeout = 1800; # 30min
      on-timeout = "brightnessctl -s set 0%"; # Complete dim
      on-resume = "brightnessctl -r";
    }
    # NOTE: Suspend listener removed - breaks HDMI hotplug on Asahi Linux
    # This will be re-enabled once the Asahi kernel DCP driver is fixed
  ];
}
