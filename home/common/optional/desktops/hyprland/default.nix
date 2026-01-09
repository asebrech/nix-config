{
  osConfig,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    # extra settings
    ./binds.nix
    ./rules.nix
    ./scripts.nix

    #hyprland utilities
    ./hyprlock.nix
    ./wlogout.nix
    ./preview-share-picker.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    systemd = {
      enable = true;
      variables = [ "--all" ]; # fix for https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#programs-dont-work-in-systemd-services-but-do-on-the-terminal
    };

    settings = {
      debug = {
        disable_logs = true;
      };
      env = [
      ];
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
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

      workspace = (
        let
          workspaceIDs = lib.flatten [
            (lib.range 1 10) # workspaces 1 through 10, Hyprland does not allow ws 0 :/
            "special" # add the special/scratchpad ws
          ];
          isPrimary = x: x ? primary && x.primary;
          primary = lib.lists.findFirst isPrimary { } osConfig.monitors;
        in
        # workspace structure to build "[workspace], monitor:[name], default:[bool], persistent:[bool]"
        map (
          id:
          let
            id_as_string = toString id;
            # determine if the monitor is intended to display a specific workspace
            monitor = lib.lists.findFirst (
              x: x ? "workspace" && id_as_string == x.workspace
            ) primary osConfig.monitors;
            # workspace 1 and any workspaces specific to the non-primary monitors are persistent
            persistent = if (id == 1 || !(isPrimary monitor)) then ", persistent:true" else "";
          in
          "${id_as_string}, monitor:${monitor.name}, default:true" + persistent
        ) workspaceIDs
      );
      #
      # ========== Behavior ==========
      #
      binds = {
        workspace_center_on = 1; # Whether switching workspaces should center the cursor on the workspace (0) or on the last active window for that workspace (1)
      };
      cursor = {
        inactive_timeout = 3;
        hide_on_key_press = true;
        enable_hyprcursor = true;
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = false;
      };
      decoration = {
        rounding = 10;
        active_opacity = 0.95;
        inactive_opacity = 0.85;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
      };
      misc = {
        force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background.
        mouse_move_enables_dpms = true; # wake up monitors on mouse movement
        key_press_enables_dpms = true; # wake up monitors on key press
      };
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0; # -1.0 to 1.0, 0 means no modification.
        touchpad = {
          natural_scroll = false;
        };
      };
      gestures = {
        workspace_swipe = false;
      };

      #
      # ========== Autostart ==========
      #
      # exec-once = "${startupScript}/path";
      # To determine path, run `which foo`
      exec-once = [
        "[workspace 1 silent]copyq"
      ];

    };

  };

  programs.zsh.shellAliases = {
    hc = "hyprctl";
    hcc = "hyprctl clients";
    hcm = "hyprctl monitors";
  };
}
