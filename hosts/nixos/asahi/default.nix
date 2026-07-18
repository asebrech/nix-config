{ lib, ... }:
{
  imports = lib.flatten [
    #
    # ========== Hardware ==========
    #
    # NOTE: hardware imports are explicit (no scanPaths) because ./firmware
    # is a data directory, not a nix module
    ./hardware-configuration.nix
    ./apple-silicon-support
    ./host-spec.nix

    (map lib.custom.relativeToRoot (
      #
      # ========== Required Configs ==========
      #
      [
        "hosts/common/core"
      ]
      ++
        #
        # ========== Optional Configs ==========
        #
        (map (f: "hosts/common/optional/${f}") [
          # Services
          "services/openssh.nix" # allow remote SSH access
          "services/gnome-keyring.nix" # libsecret keyring daemon, unlocked via cosmic-greeter PAM
          "services/protonvpn.nix" # Proton VPN
          "services/docker.nix" # Docker container runtime

          # Desktop Environment
          "cosmic.nix" # COSMIC desktop with cosmic-greeter
          #"plymouth.nix" # boot splash screen
        ])
    ))
  ];

  hardware.asahi.enable = true;
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # Binary cache for the Asahi kernel (built by nixos-apple-silicon CI)
  nix.settings = {
    extra-substituters = [ "https://nixos-apple-silicon.cachix.org" ];
    extra-trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      # EFI variables are read-only on Apple Silicon; let bootctl treat
      # those write failures as non-fatal (needed since systemd 260)
      graceful = true;
      # The Asahi ESP is small (~500MB) and each generation stores its
      # kernel+initrd there; cap entries so the ESP can't fill up again
      configurationLimit = 5;
    };
    efi.canTouchEfiVariables = false;
  };

  boot.initrd = {
    systemd.enable = true;
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
