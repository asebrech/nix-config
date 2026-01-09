# FIXME(starter): the declarations here will ONLY be applied to Linux-based machines.
# Core home functionality that will only work on Linux
{
  osConfig,
  lib,
  ...
}:
{
  home.sessionVariables = lib.optionalAttrs (osConfig.hostSpec.useWayland or false) {
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    CLUTTER_BACKEND = "wayland"; # for gnome-shell
    SDL_VIDEODRIVER = "wayland"; # for SDL apps
    NIXOS_OZONE_WL = "1"; # for chromium, vscode, electron, etc
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1"; # for firefox
    WLR_NO_HARDWARE_CURSORS = "1"; # this forces software cursors and can solve disappearing cursors
  };
}
