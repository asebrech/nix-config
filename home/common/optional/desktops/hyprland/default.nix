{
  osConfig,
  pkgs,
  ...
}:

{
  imports = [
    # extra settings
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
      #
      # ========== Monitor ==========
      #
      # parse the monitor spec defined in nix-config/hosts/<host>.nix
      monitor = (
        map (
          m:
          "${m.name},${
            if m.enabled then
              "${toString m.width}x${toString m.height}@${toString m.refreshRate}"
              + ",${toString m.x}x${toString m.y},1"
              + ",transform,${toString m.transform}"
              + ",vrr,${toString m.vrr}"
            else
              "disable"
          }"
        ) osConfig.monitors
      );
    };
  };

  programs.zsh.shellAliases = {
    hc = "hyprctl";
    hcc = "hyprctl clients";
    hcm = "hyprctl monitors";
  };
}
