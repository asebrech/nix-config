{ ... }:
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
}
