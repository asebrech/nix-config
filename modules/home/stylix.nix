{
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.hostSpec.isAutoStyled {
    # Stylix targets are automatically enabled via autoEnable in the host module
    # Add explicit target configuration here only if you need to disable or customize specific apps
  };
}
