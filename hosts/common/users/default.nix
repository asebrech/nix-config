{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

let
  # Generate a list of public key contents to use by ssh
  genPubKeyList =
    user:
    let
      keyPath = (lib.custom.relativeToRoot "hosts/common/users/${user}/keys/");
    in
    if (lib.pathExists keyPath) then
      lib.lists.forEach (lib.filesystem.listFilesRecursive keyPath) (key: lib.readFile key)
    else
      [ ];

  # List of public keys that will allow auth to any user, across systems
  superPubKeys = genPubKeyList "super";

  inherit (config) hostSpec;
in
{
  # No matter what environment we are in we want these tools for root, and the user(s)
  programs.zsh.enable = true;
  programs.git.enable = true;
  environment = {
    systemPackages = [
      pkgs.just
      pkgs.rsync
    ];
  };

  # Import all non-root users
  users = {
    mutableUsers = false; # Required for password to be set via sops during system activation!
    users =
      (lib.mergeAttrsList (
        map (user: {
          "${user}" =
            let
              sopsHashedPasswordFile = lib.optionalString (
                !config.hostSpec.isMinimal
              ) config.sops.secrets."passwords/${user}".path;
              userPath = lib.custom.relativeToRoot "hosts/common/users/${user}/nixos.nix";
            in
            {
              name = user;
              shell = pkgs.zsh; # Default Shell
              # Adds ssh pub key access to the user to the defined user keys AND the super keys
              openssh.authorizedKeys.keys = (genPubKeyList user) ++ superPubKeys;
              home = "/home/${user}";
              # Decrypt password to /run/secrets-for-users/ so it can be used to create the user
              hashedPasswordFile = sopsHashedPasswordFile; # Blank if sops isn't working
            }
            # Add in per-user values if they exist
            // lib.optionalAttrs (lib.pathExists userPath) (
              import userPath {
                inherit config lib;
              }
            );
        }) config.hostSpec.users
      ))
      // {
        root = {
          shell = pkgs.zsh;
          hashedPasswordFile = config.users.users.${config.hostSpec.primaryUsername}.hashedPasswordFile;
          hashedPassword = lib.mkForce config.users.users.${config.hostSpec.primaryUsername}.hashedPassword;
          # root's ssh key are mainly used for remote deployment
          openssh.authorizedKeys.keys =
            config.users.users.${config.hostSpec.primaryUsername}.openssh.authorizedKeys.keys;
        };
      };
  };
}
// lib.optionalAttrs (inputs ? "home-manager") {
  home-manager =
    let
      fullPathIfExists =
        path:
        let
          fullPath = lib.custom.relativeToRoot path;
        in
        lib.optional (lib.pathExists fullPath) fullPath;
    in
    {
      extraSpecialArgs = {
        inherit
          inputs
          pkgs
          ;

        # pass common modules set in hosts through to home
        # see also: home/common/core/default.nix
        inherit (config)
          hostSpec
          ;
      };
      # Add all non-root users to home-manager
      users =
        (lib.mergeAttrsList (
          map (user: {
            "${user}".imports = lib.flatten [
              (lib.optional (!hostSpec.isMinimal) (
                map (fullPathIfExists) [
                  "home/${user}/${hostSpec.hostName}.nix"
                  "home/${user}/common"
                ]
              ))
              # Static module with common values avoids duplicate file per user
              (
                { ... }:
                {
                  home = {
                    stateVersion = "25.11";
                    homeDirectory = "/home/${user}";
                    username = "${user}";
                  };
                }
              )
            ];
          }) config.hostSpec.users
        ))
        // {
          root = {
            home.stateVersion = "25.11"; # Avoid error
            programs.zsh.enable = true;
          };
        };
    };
}
