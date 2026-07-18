# Specifications For Differentiating Hosts
{
  config,
  lib,
  ...
}:
{
  options.hostSpec = lib.mkOption {
    type = lib.types.submodule {
      freeformType = with lib.types; attrsOf str;
      options = {
        # Data variables that don't dictate configuration settings
        username = lib.mkOption {
          type = lib.types.str;
          description = "The username of the host";
        };
        hostName = lib.mkOption {
          type = lib.types.str;
          description = "The hostname of the host";
        };
        email = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          description = "The email of the user";
        };
        handle = lib.mkOption {
          type = lib.types.str;
          description = "The handle of the user (eg: github user)";
        };
        home = lib.mkOption {
          type = lib.types.str;
          description = "The home directory of the user";
          default = "/home/${config.hostSpec.username}";
        };

        # Configuration Settings
        isMinimal = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Used to indicate a minimal host";
        };
      };
    };
  };
}
