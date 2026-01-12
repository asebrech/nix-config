{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.hyprland-preview-share-picker or pkgs.slurp
  ];

  home.file = {
    "${config.xdg.configHome}/hypr/xdph.conf" = {
      text = ''
        screencopy {
          allow_token_by_default = true
          custom_picker_binary = hyprland-preview-share-picker
        }
      '';
    };
  };
}
