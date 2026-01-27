# Pulseaudio modules - Output and Input with drawer
# From mechabar: modules/pulseaudio.jsonc
let
  scriptsPath = "~/.config/waybar/scripts";
in
{
  #-----------------
  # Pulseaudio group with drawer
  #-----------------
  # Source: modules/pulseaudio.jsonc
  "group/pulseaudio" = {
    orientation = "horizontal";
    modules = [
      "pulseaudio#output"
      "pulseaudio#input"
    ];
    drawer = {
      transition-left-to-right = false;
    };
  };

  #-----------------
  # Output device (speakers/headphones)
  #-----------------
  "pulseaudio#output" = {
    format = "{icon} {volume}%";
    format-muted = "{icon} {volume}%";
    format-icons = {
      default = [
        "󰕿"
        "󰖀"
        "󰕾"
      ];
      default-muted = "󰝟";
      headphone = "󰋋";
      headphone-muted = "󰟎";
      headset = "󰋎";
      headset-muted = "󰋐";
    };
    min-length = 7;
    max-length = 7;
    on-click = "${scriptsPath}/volume.sh output mute";
    on-scroll-up = "${scriptsPath}/volume.sh output raise";
    on-scroll-down = "${scriptsPath}/volume.sh output lower";
    tooltip-format = "<b>Output Device</b>: {desc}";
  };

  #-----------------
  # Input device (microphone)
  #-----------------
  "pulseaudio#input" = {
    format = "{format_source}";
    format-source = "󰍬 {volume}%";
    format-source-muted = "󰍭 {volume}%";
    min-length = 7;
    max-length = 7;
    on-click = "${scriptsPath}/volume.sh input mute";
    on-scroll-up = "${scriptsPath}/volume.sh input raise";
    on-scroll-down = "${scriptsPath}/volume.sh input lower";
    tooltip-format = "<b>Input Device</b>: {desc}";
  };
}
