{
  pkgs,
  ...
}:

{
  imports = [
    # extra settings
    ./monitors.nix
    ./bindings
    ./envs.nix
    ./input.nix
    ./autostart.nix
    ./windows.nix
    ./looknfeel.nix
    ./apps

    #hyprland utilities
    ./hyprlock.nix
    ./hypridle.nix
    ./xdph.nix
    ./hyprland-preview-share-picker.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    systemd = {
      enable = true;
      variables = [ "--all" ]; # fix for https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#programs-dont-work-in-systemd-services-but-do-on-the-terminal
    };
    settings = {
      # Vicinae integration
      exec-once = [ "vicinae server" ];
    };
  };
}
