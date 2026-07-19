# niri configuration: the stock default config.kdl (search for "ADAPTED"
# to see the few necessary changes: ghostty terminal, noctalia launcher
# and shell startup), preceded by per-host output/startup fragments.
{
  lib,
  pkgs,
  osConfig,
  ...
}:
{
  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        xwayland-satellite # xwayland support, auto-spawned by niri when on PATH
        ;
    };
    file =
      let
        hostPath = "hosts/nixos/${osConfig.hostSpec.hostName}/niri";
        finalConfig =
          lib.flatten [
            # order matters
            (map lib.custom.relativeToRoot [
              "${hostPath}/startup.kdl"
            ])
            ./config.kdl
          ]
          |> lib.concatMapStringsSep "\n" lib.readFile;
      in
      {
        ".config/niri/config.kdl".text = finalConfig;
      };
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
