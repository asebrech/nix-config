# Module: Temperature
# Adapted from mechabar: modules/temperature.jsonc
{
  temperature = {
    thermal-zone = 1;
    critical-threshold = 90;
    interval = 10;
    format = "{icon} {temperatureC}°C";
    format-critical = "󰀦 {temperatureC}°C";
    format-icons = [
      "󱃃"
      "󰔏"
      "󱃂"
    ];
    min-length = 8;
    max-length = 8;
    tooltip-format = "Fahrenheit: {temperatureF}°F";
  };
}
