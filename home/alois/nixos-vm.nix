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
    # FIXME(starter): add or remove any optional config directories or files ehre
    common/optional/browsers
    common/optional/desktops
    common/optional/comms
    common/optional/media
    common/optional/vscode.nix

    common/optional/sops.nix
  ];

  #
  # ========== Host-specific Monitor Spec ==========
  #
  # This uses the nix-config/modules/home/montiors.nix module which defaults to enabled.
  # Your nix-config/home-manger/<user>/common/optional/desktops/foo.nix WM config should parse and apply these values to it's monitor settings
  # If on hyprland, use `hyprctl monitors` to get monitor info.
  # https://wiki.hyprland.org/Configuring/Monitors/

  monitors = [
    {
      name = "Virtual-1";
      width = 3840;
      height = 2160;
      refreshRate = 60;
      # vrr = 1;
      primary = true;
    }
  ];

}
