# Custom module: System update indicator for NixOS flakes
# Shows when flake was last updated and provides click action
let
  scriptsPath = "~/.config/waybar/scripts";
in
{
  #-----------------
  # System update indicator
  # Shows flake.lock age and provides update action
  # Icons: 󰸟 (recent), 󰄠 (older than 7 days)
  #-----------------
  "custom/system_update" = {
    exec = "${scriptsPath}/system-update.sh";
    return-type = "json";
    interval = 300; # Update display every 5 minutes
    min-length = 2;
    max-length = 2;
    on-click = "alacritty -e sh -c 'cd ~/nix-config && nix flake update && echo && echo Press any key to close... && read -n1'";
    signal = 1; # Update with pkill -RTMIN+1 waybar
  };
}
