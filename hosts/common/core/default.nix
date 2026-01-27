# Modify this file and the other .nix files in `nix-config/hosts/common/core/` to declare
# settings that will occur across all hosts

# IMPORTANT: This is used by NixOS and nix-darwin so options must exist in both!
{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  platform = if isDarwin then "darwin" else "nixos";
  platformModules = "${platform}Modules";
in
{
  imports = lib.flatten [
    inputs.home-manager.${platformModules}.home-manager
    inputs.sops-nix.${platformModules}.sops

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/hosts/common"
      "modules/hosts/${platform}"
      "hosts/common/core/${platform}.nix"
      "hosts/common/core/sops.nix" # Core because it's used for backups, mail
      "hosts/common/core/ssh.nix"
      #"hosts/common/core/services" # uncomment this line if you add any modules to services directory
      "hosts/common/users/primary"
      "hosts/common/users/primary/${platform}.nix"
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
  # On darwin it's important this is outside home-manager
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
}
