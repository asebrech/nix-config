{ lib, ... }:
{
  imports = lib.flatten [
    #
    # ========== Hardware ==========
    #
    ./hardware-configuration.nix
    ./apple-silicon-support

    (map lib.custom.relativeToRoot (
      #
      # ========== Required Configs ==========
      #
      [
        "hosts/common/core"

        #
        # ========== Non-Primary Users to Create ==========
        #
        # The primary user, defined in `nix-config/hosts/common/users`, is added by default, via
        # `hosts/common/core` above.
        # To create additional users, specify the path to their config file, as shown in the commented line below, and create/modify
        # the specified file as required. See `nix-config/hosts/common/users/exampleSecondUser` for more info.

        #"hosts/common/users/exampleSecondUser"
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

  #
  # ========== Host Specification ==========
  #

  # Declare any host-specific hostSpec options. Note that hostSpec options pertaining to
  # more than one host can be declared in `nix-config/hosts/common/core/` see the default.nix file there
  # for examples.
  hostSpec = {
    hostName = "asahi";
    # NOTE: theming, wallpaper, and display scaling are managed in COSMIC Settings
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      # When using plymouth, initrd can expand by a lot each time, so limit how many we keep around
      #configurationLimit = lib.mkDefault 10;
    };
    efi.canTouchEfiVariables = false;
    #timeout = 3;
  };

  boot.initrd = {
    systemd.enable = true;
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
