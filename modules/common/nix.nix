# Nix settings that are common to hosts and home-manager configs
{
  inputs,
  config,
  lib,
  ...
}:
{
  nix = {
    # Deduplicate and optimize nix store
    optimise.automatic = true;

    settings = {
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

      warn-dirty = false;
      allow-import-from-derivation = true;

      trusted-users = [ "@wheel" ];
    };

    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
}
