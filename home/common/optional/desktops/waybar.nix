{ pkgs, ... }:
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
    settings = {
      #
      # ========== Main Bar ==========
      #
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "pulseaudio"
          "tray"
          "battery"
          "backlight"
          "clock#time"
          "clock#date"
        ];

        # ========= Modules =========

        "hyprland/workspaces" = {
          all-outputs = false;
          disable-scroll = true;
          on-click = "activate";
          show-special = true;
        };

        "clock#time" = {
          interval = 1;
          format = "{:%H:%M}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 10;
          format = "{:%d.%b.%y.%a}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "backlight" = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "pulseaudio" = {
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = "  muted";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };
      };
    };
  };
}
