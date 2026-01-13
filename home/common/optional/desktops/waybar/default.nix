{ pkgs, ... }:
{
  imports = [
    ./config.nix
    ./style.nix
  ];

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  # Let it try to start a few more times
  systemd.user.services.waybar = {
    Unit.StartLimitInterval = 0;
  };

  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
    systemd = {
      enable = true;
    };
  };
}
