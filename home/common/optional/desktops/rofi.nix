{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "alacritty";
    extraConfig = {
      modi = "drun,run,ssh,window";
      show-icons = true;
      drun-display-format = "{name}";
      disable-history = false;
      sidebar-mode = false;
    };
  };
}
