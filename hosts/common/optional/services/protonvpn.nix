{ pkgs, ... }:
{
  # Proton VPN GUI from unstable: the stable build is still broken on aarch64
  # (proton-vpn-local-agent build script hardcodes the x86_64 target path)
  environment.systemPackages = with pkgs; [
    unstable.proton-vpn
  ];

  # Allow VPN traffic through firewall
  networking.firewall = {
    # Allow VPN protocols - use loose reverse path filtering for VPN
    checkReversePath = "loose";
  };
}
