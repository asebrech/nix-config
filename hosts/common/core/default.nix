# Core configuration shared across all NixOS hosts
{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  secrets,
  ...
}:
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    inputs.nix-index-database.nixosModules.nix-index
    # `, foo` runs any program without installing it
    # NOTE: don't enable in hm as well because it will barf eventually
    { programs.nix-index-database.comma.enable = true; }

    (map lib.custom.relativeToRoot [
      "modules/hosts/common"

      "hosts/common/core/nixos.nix"
      "hosts/common/core/sops.nix"
      "hosts/common/core/ssh.nix"

      "hosts/common/users/"
    ])
  ];

  #
  # ========== Core Host Specifications ==========
  #
  hostSpec = {
    primaryUsername = lib.mkDefault "neo";
    users = [ "neo" ];
    handle = "asebrech";
    inherit (secrets)
      domain
      email
      userFullName
      networking
      ;
  };

  networking.hostName = config.hostSpec.hostName;

  # System-wide packages, in case we log in as root
  environment.systemPackages = [ pkgs.openssh ];

  # If there is a conflict file that is backed up, use this extension
  home-manager.backupFileExtension = "bk";

  #
  # ========== Overlays ==========
  #
  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  #
  # ========== Basic Shell Enablement ==========
  #
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
}
