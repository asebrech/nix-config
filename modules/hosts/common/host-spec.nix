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
        primaryUsername = lib.mkOption {
          type = lib.types.str;
          description = "The primary administrative username of the host";
        };
        # FIXME: deprecated. Use either primaryUsername or map over users
        username = lib.mkOption {
          type = lib.types.str;
          default = config.hostSpec.primaryUsername;
          description = "The username of the host";
        };
        users = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ config.hostSpec.primaryUsername ];
          description = "The users of the host";
        };
        hostName = lib.mkOption {
          type = lib.types.str;
          description = "The hostname of the host";
        };
        email = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          description = "The email of the user";
        };
        networking = lib.mkOption {
          default = { };
          type = lib.types.attrsOf lib.types.anything;
          description = "An attribute set of networking information";
        };
        domain = lib.mkOption {
          type = lib.types.str;
          default = "local";
          description = "The domain of the host";
        };
        userFullName = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "The full name of the user";
        };
        handle = lib.mkOption {
          type = lib.types.str;
          description = "The handle of the user (eg: github user)";
        };
        home = lib.mkOption {
          type = lib.types.str;
          default = "/home/${config.hostSpec.primaryUsername}";
          description = "The home directory of the primary user";
        };
        timeZone = lib.mkOption {
          type = lib.types.str;
          default = "Europe/Paris";
          description = "The time zone of the host";
        };

        # Configuration Settings
        isMinimal = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Used to indicate a minimal host";
        };
        isAutoStyled = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Used to indicate a host that wants stylix auto styling";
        };
        theme = lib.mkOption {
          type = lib.types.str;
          default = "catppuccin-mocha";
          description = "The base16 theme name to use for styling (from pkgs.base16-schemes)";
        };
        wallpaper = lib.mkOption {
          type = lib.types.nullOr (lib.types.either lib.types.path lib.types.str);
          default = null;
          description = "Path to the wallpaper image used by stylix";
        };
      };
    };
  };
}
