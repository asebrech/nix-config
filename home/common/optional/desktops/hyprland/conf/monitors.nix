{
  config,
  osConfig,
  lib,
  ...
}:
{
  # Generate static monitor config ONLY if hyprdynamicmonitors is not enabled
  # On Asahi, hyprdynamicmonitors manages monitors.conf as a symlink to profile files
  home.file."${config.home.homeDirectory}/.config/hypr/monitors.conf" =
    lib.mkIf (!config.home.hyprdynamicmonitors.enable)
      {
        text = lib.concatMapStringsSep "\n" (
          m:
          "monitor = ${m.name},${toString m.width}x${toString m.height}@${toString m.refreshRate},${toString m.x}x${toString m.y},${toString m.scale}"
        ) osConfig.monitors;
      };

  wayland.windowManager.hyprland.settings = {
    source = [ "${config.home.homeDirectory}/.config/hypr/monitors.conf" ];
  };
}
