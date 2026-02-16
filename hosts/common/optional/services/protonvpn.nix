{ pkgs, ... }:
{
  # Install Proton VPN GUI from unstable (stable version is broken on aarch64)
  environment.systemPackages = with pkgs; [
    unstable.protonvpn-gui
  ];

  # Allow VPN traffic through firewall
  networking.firewall = {
    # Allow VPN protocols - use loose reverse path filtering for VPN
    checkReversePath = "loose";
  };
}
