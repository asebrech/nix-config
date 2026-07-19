# niri configuration: the stock default config.kdl (search for "ADAPTED"
# to see the few necessary changes: ghostty terminal, noctalia launcher,
# shell startup, lock and screenshot binds).
{
  lib,
  pkgs,
  ...
}:
{
  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        xwayland-satellite # xwayland support, auto-spawned by niri when on PATH
        ;
    };
    file.".config/niri/config.kdl".source = ./config.kdl;
  };

  # GUI polkit agent for the niri session
  systemd.user.services.polkit-mate-agent = {
    Unit = {
      Description = "MATE polkit authentication agent";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "niri.service" ];
  };
}
