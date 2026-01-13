{ ... }:
{
  programs.hyprlock = {
    enable = true;
    importantPrefixes = [
      "$"
      "monitor"
      "size"
      "source"
    ];
    settings = {
      general = {
        ignore_empty_input = true;
      };

      animations = {
        enabled = false;
      };

      auth = {
        "fingerprint:enabled" = true;
      };
    };
  };
}
