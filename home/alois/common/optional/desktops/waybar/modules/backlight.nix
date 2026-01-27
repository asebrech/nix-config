# Backlight module
# From mechabar: modules/backlight.jsonc
let
  scriptsPath = "~/.config/waybar/scripts";
in
{
  # Source: modules/backlight.jsonc
  backlight = {
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
    min-length = 7;
    max-length = 7;
    on-scroll-up = "${scriptsPath}/backlight.sh up";
    on-scroll-down = "${scriptsPath}/backlight.sh down";
    tooltip = false;
  };
}
