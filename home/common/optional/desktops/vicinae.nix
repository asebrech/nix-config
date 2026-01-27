{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:
{
  # Only enable on Linux with Wayland
  config = lib.mkIf (pkgs.stdenv.isLinux && osConfig.hostSpec.useWayland) {
    services.vicinae = {
      enable = true;
      extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        hypr-keybinds
        nix
      ];
      systemd = {
        enable = true;
        autoStart = true; # Auto-restart on config changes
        environment = {
          USE_LAYER_SHELL = "1";
        };
      };
      settings = {
        close_on_focus_loss = true;
        pop_to_root_on_close = true;
      };
    };

    # Restart vicinae on home-manager activation to pick up new applications
    # Run after reloadSystemd to ensure desktop files are in place
    home.activation.restartVicinae = lib.hm.dag.entryAfter [ "reloadSystemd" ] ''
      # Small delay to ensure desktop database is updated
      ${pkgs.coreutils}/bin/sleep 1
      if ${pkgs.systemd}/bin/systemctl --user is-active vicinae.service >/dev/null 2>&1; then
        ${pkgs.systemd}/bin/systemctl --user restart vicinae.service || true
        echo "Restarted vicinae service to pick up new applications"
      fi
    '';
  };
}
