{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    # Environment variables (cursor, scaling, wayland)
    ./conf/envs.nix

    # Monitor configuration
    ./conf/monitors.nix

    # Autostart applications
    ./autostart.nix

    # Hyprland utilities
    ./hyprlock.nix
    ./hypridle.nix
    ./xdph.nix
    ./wlogout.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      # General window layout (ML4W style)
      general = import ./conf/general.nix;

      # Decorations (ML4W style)
      decoration = import ./conf/decorations.nix;

      # Animations (ML4W End-4 style)
      animations = import ./conf/animations.nix;

      # Input settings
      input = import ./conf/input.nix;

      # Layouts
      inherit (import ./conf/layouts.nix) dwindle master binds;

      # Misc settings
      misc = import ./conf/misc.nix;

      # Keybindings (ML4W adapted)
      bind = lib.mapAttrsToList (key: cmd: "${key}, ${cmd}") (
        import ./conf/keybindings.nix { inherit pkgs; }
      );

      # Mouse bindings
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      # Window rules (ML4W adapted)
      windowrule = import ./conf/windowrules.nix;
    };
  };
}
