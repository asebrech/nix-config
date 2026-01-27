# MPRIS media player module
# From mechabar: modules/mpris.jsonc
_: {
  # Source: modules/mpris.jsonc
  mpris = {
    format = "{player_icon} {title} - {artist}";
    format-paused = "{status_icon} {title} - {artist}";
    tooltip-format = "Playing: {title} - {artist}";
    tooltip-format-paused = "Paused: {title} - {artist}";
    player-icons = {
      default = "󰐊";
    };
    status-icons = {
      paused = "󰏤";
    };
    max-length = 1000;
  };
}
