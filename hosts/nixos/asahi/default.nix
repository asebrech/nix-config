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

  # Docked usage: when the external monitor deep-sleeps it drops HPD, logind
  # then sees "lid closed, no dock" and suspends — after which the display
  # won't come back until the lid is opened (Asahi DCP resume issue). On AC
  # a closed lid should therefore never suspend; battery keeps the default.
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";

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
    # Load the Apple display stack in the initrd so the LUKS passphrase
    # prompt shows up on external displays (HDMI) too, not only on the
    # internal panel. The DCP firmware is already running (loaded by
    # iBoot/m1n1), so no extra firmware is needed in the initrd.
    # mux_apple_display_crossbar and phy_apple_atc are runtime (device-tree)
    # dependencies of the DCP that modprobe cannot infer; without them the
    # DCP probe defers with "Failed to get dp-xbar: -517" until stage 2.
    kernelModules = [
      "appledrm"
      "mux_apple_display_crossbar"
      "phy_apple_atc"
    ];
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
