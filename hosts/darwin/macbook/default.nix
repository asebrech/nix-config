{
  lib,
  ...
}:
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      #
      # ========== Required Configs ==========
      #
      "hosts/common/core"

      #
      # ========== Optional Configs ==========
      #
      # Note: openssh.nix is NixOS-only (uses firewall settings not available on macOS)
    ])
  ];

  #
  # ========== Host Specification ==========
  #

  # Note that hostSpec options pertaining to more than one host can be declared in
  # `nix-config/hosts/common/core/` see the default.nix file there for examples.
  hostSpec = {
    hostName = "macbook";
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking = {
    hostName = "macbook";
    computerName = "macbook";
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = 5;
}
