# Module: CPU
# Adapted from mechabar: modules/cpu.jsonc
{
  cpu = {
    interval = 10;
    format = "󰍛 {usage}%";
    format-warning = "󰀨 {usage}%";
    format-critical = "󰀨 {usage}%";
    min-length = 7;
    max-length = 7;
    states = {
      warning = 75;
      critical = 90;
    };
    tooltip-format = "CPU Usage: {usage}%\nLoad: {load}";
  };
}
