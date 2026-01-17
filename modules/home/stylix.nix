{
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.hostSpec.isAutoStyled {
    # Disable Stylix targets for apps we don't use
    stylix.targets = {
      anki.enable = false;
    };

    # Stylix targets are automatically enabled via autoEnable in the host module
    # Add explicit target configuration here only if you need to disable or customize specific apps
  };
}
