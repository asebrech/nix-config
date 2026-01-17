{
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.hostSpec.isAutoStyled {
    # Stylix targets are automatically enabled via autoEnable in the host module
    # You can enable specific targets here if needed, like:
    # stylix.targets.vicinae.enable = true; # Once available in Stylix
  };
}
