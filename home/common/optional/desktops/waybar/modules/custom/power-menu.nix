# Custom module: Power menu
# Adapted from mechabar: modules/custom/power_menu.jsonc
let
  scriptsPath = "~/.config/waybar/scripts";
in
{
  #-----------------
  # Power menu
  #-----------------
  "custom/power_menu" = {
    format = "󰤄";
    on-click = "alacritty -e " + scriptsPath + "/power-menu.sh";
    tooltip-format = "Power Menu";
  };
}
