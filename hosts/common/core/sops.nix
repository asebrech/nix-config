# hosts level sops. see home/[user]/common/optional/sops.nix for home/user level
{
  lib,
  inputs,
  config,
  ...
}:
let
  sopsFolder = toString inputs.nix-secrets + "/sops";
in
{
  #the import for inputs.sops-nix.nixosModules.sops is handled in hosts/common/core/default.nix so that it can be dynamically input according to the platform

  sops = {
    defaultSopsFile = "${sopsFolder}/${config.hostSpec.hostName}.yaml";
    validateSopsFiles = false;
    age = {
      # automatically import host SSH keys as age keys
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
    # secrets will be output to /run/secrets
    # e.g. /run/secrets/msmtp-password
    # secrets required for user creation are handled in respective ./users/<username>.nix files
    # because they will be output to /run/secrets-for-users and only when the user is assigned to a host.
  };

  # For home-manager a separate age key is used to decrypt secrets and must be placed onto the host. This is because
  # the user doesn't have read permission for the ssh service private key. However, we can bootstrap the age key from
  # the secrets decrypted by the host key, which allows home-manager secrets to work without manually copying over
  # the age key.
  # NOTE: the "keys/age" attr name is shared across users, so with more than
  # one user in hostSpec.users the last one would win. Restructure to a
  # per-user secret name before adding a second user.
  sops.secrets = lib.mergeAttrsList (
    map (user: {
      # These age keys are unique for the user on each host and are generated on their own
      # (i.e. they are not derived from an ssh key).
      "keys/age" = {
        owner = config.users.users.${user}.name;
        # We need to ensure the entire directory structure is that of the user...
        path = "/home/${user}/.config/sops/age/keys.txt";
      }
      // lib.optionalAttrs (config.users.users.${user} ? group) {
        inherit (config.users.users.${user}) group;
      };
      # extract password/username to /run/secrets-for-users/ so it can be used to create the user
      "passwords/${user}" = {
        sopsFile = "${sopsFolder}/shared.yaml";
        neededForUsers = true;
      };
    }) config.hostSpec.users
  );

  # The containing folders are created as root and if this is the first ~/.config/ entry,
  # the ownership is busted and home-manager can't target because it can't write into .config...
  # In the future this may not be needed, depending on how https://github.com/Mic92/sops-nix/issues/381 is fixed
  system.activationScripts.sopsSetAgeKeyOwnership =
    let
      mkOwnershipCmd =
        user:
        let
          ageFolder = "/home/${user}/.config/sops/age";
          inherit (config.users.users.${user}) group;
        in
        ''
          mkdir -p ${ageFolder} || true
          chown -R ${user}:${group} /home/${user}/.config
        '';
    in
    lib.concatStringsSep "\n" (map mkOwnershipCmd config.hostSpec.users);
}
