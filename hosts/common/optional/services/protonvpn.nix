{ pkgs, ... }:
{
  # Proton VPN GUI from unstable: the stable build is still broken on aarch64
  # (proton-vpn-local-agent build script hardcodes the x86_64 target path)
  environment.systemPackages = with pkgs; [
    unstable.proton-vpn
  ];

  # Launch the VPN app on session start (pair with "Auto Connect" in the
  # app settings so the connection comes up by itself)
  environment.etc."xdg/autostart/proton.vpn.app.gtk.desktop".source =
    "${pkgs.unstable.proton-vpn}/share/applications/proton.vpn.app.gtk.desktop";

  # Allow VPN traffic through firewall
  networking.firewall = {
    # Allow VPN protocols - use loose reverse path filtering for VPN
    checkReversePath = "loose";
  };
}
