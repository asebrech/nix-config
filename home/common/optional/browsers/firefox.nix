{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    # Adopt the 26.05 XDG default explicitly; with home.stateVersion < 26.05
    # home-manager would otherwise keep the legacy ~/.mozilla location (and warn)
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
