{
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.hostSpec.isAutoStyled {
    stylix = {
      enableReleaseChecks = false; # Using master branch for vicinae support
    };
  };
}
