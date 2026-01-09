#
# Dunst
# Notification Daemon
#
{ lib, pkgs, ... }:
{
  home.packages = lib.attrValues {
    inherit (pkgs) libnotify; # required by dunst
  };

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = "16x16";
    };
    settings = {
      global = {
        # Allow a small subset of html markup
        allow_markup = "yes";

        # The format of the message
        format = "<b>%s</b>\\n%b";

        # Sort messages by urgency
        sort = "yes";

        # Show how many messages are currently hidden
        indicate_hidden = "yes";

        # Alignment of message text
        alignment = "left";

        # Show age of message if message is older than show_age_threshold seconds
        show_age_threshold = 60;

        # Split notifications into multiple lines
        word_wrap = "yes";

        # Ignore newlines '\\n' in notifications
        ignore_newline = "no";

        # The geometry of the window
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "10x50";

        # Shrink window if it's smaller than the width
        shrink = "no";

        # Draw a line between multiple notifications
        separator_height = 2;

        # Padding between text and separator
        padding = 8;

        # Horizontal padding
        horizontal_padding = 8;

        # Define frame around notification window
        frame_width = 2;

        # Transparency of notification window [0-100]
        transparency = 10;

        # Idle time
        idle_threshold = 120;

        # Font
        font = "monospace 10";

        # Line height
        line_height = 0;

        # Show notification icon
        show_indicators = "yes";
      };

      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
        timeout = 10;
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
        timeout = 10;
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8";
        timeout = 0;
      };
    };
  };
}
