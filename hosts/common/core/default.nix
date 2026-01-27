# Modify this file and the other .nix files in `nix-config/hosts/common/core/` to declare
# settings that will occur across all hosts

# Core configuration shared across all NixOS hosts
{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/hosts"
      "hosts/common/core/nixos.nix"
      "hosts/common/core/sops.nix" # Core because it's used for backups, mail
      "hosts/common/core/ssh.nix"
      #"hosts/common/core/services" # uncomment this line if you add any modules to services directory
      "hosts/common/users/primary"
      "hosts/common/users/primary/nixos.nix"
    ])
  ];

  #
  # ========== Core Host Specifications ==========
  #
  # Modify the hostSpec options below to define values that are common across all hosts
  # such as the username and handle of the primary user (see also `nix-config/hosts/common/users/primary`)
  hostSpec = {
    username = "alois";
    handle = "asebrech";
    userAvatar = ../../../assets/avatar.jpg;
    # Modify the attribute sets hostSpec will inherit from your nix-secrets.
    # If you're not using nix-secrets then remove the following six lines below.
    inherit (inputs.nix-secrets)
      domain
      email
      userFullName
      networking
      ;
  };

  networking.hostName = config.hostSpec.hostName;

  # System-wide packages, in case we log in as root
  environment.systemPackages = [ pkgs.openssh ];

  # Force home-manager to use global packages
  home-manager.useGlobalPkgs = true;

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
