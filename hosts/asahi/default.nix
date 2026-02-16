{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    #
    # ========== Hardware ==========
    #
    ./hardware-configuration.nix
    ./apple-silicon-support
    ./monitors.nix

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
          "services/bluetooth.nix" # bluetooth support
          "services/openssh.nix" # allow remote SSH access
          "services/greetd.nix" # display manager with tuigreet greeter
          "services/logrotate.nix" # hyprland log rotation
          "services/x11.nix" # X11 DPI settings for xwayland apps
          "services/upower.nix" # power management and lid detection
          "services/protonvpn.nix" # Proton VPN

          # Desktop and Window Manager
          "hyprland.nix" # hyprland window manager
          "wayland.nix" # wayland packages
          #"plymouth.nix" # boot splash screen

          # System
          "audio.nix" # pipewire and cli controls
          "thunar.nix" # thunar file manager with plugins
        ])
    ))
  ];

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  # Explicitly set pkgs for asahi modules (workaround for overlay timing issue)
  hardware.asahi.pkgs = lib.mkForce pkgs;

  #
  # ========== Host Specification ==========
  #

  # Declare any host-specific hostSpec options. Note that hostSpec options pertaining to
  # more than one host can be declared in `nix-config/hosts/common/core/` see the default.nix file there
  # for examples.
  hostSpec = {
    hostName = "asahi";
    useWayland = true;
    isAutoStyled = true; # Enable Stylix theming
    theme = "catppuccin-mocha"; # Base16 Tokyo Night theme
    wallpaper = ../../assets/wallpapers/tokyo-night.jpg;
    scaling = "1"; # No scaling (100% - native resolution)
  };

  # Enable auto-login for the primary user with greetd
  autoLogin = {
    enable = false; # Disabled to see Plymouth boot splash
    username = config.hostSpec.username;
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  # Lid close behavior for clamshell mode
  # HandleLidSwitchDocked=ignore prevents suspend when external monitors are connected
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchDocked = "ignore"; # Don't suspend when docked (external monitor connected)
    HandleLidSwitchExternalPower = "suspend"; # Changed from ignore - suspend on AC power unless docked
  };

  # Prevent USB autosuspend for Bluetooth devices
  # This prevents Bluetooth keyboard/mouse from disconnecting during idle periods
  # which would leave no way to wake the system in clamshell mode with only Bluetooth input devices
  services.udev.extraRules = ''
    # Disable autosuspend for Bluetooth USB devices
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*Bluetooth*", ATTR{power/control}="on"

    # Disable autosuspend for USB hubs (Bluetooth controllers often connect through hubs)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{bDeviceClass}=="09", ATTR{power/control}="on"
  '';

  # Post-resume service to fix HDMI detection issues on Asahi Linux
  # The apple-dcp driver has known issues with HDMI HPD (Hot Plug Detect) stability after suspend/resume
  # This service runs as the user to access Hyprland socket
  systemd.user.services.hdmi-reset-after-resume = {
    description = "Reset HDMI and monitors after system resume";
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "oneshot";
      # Wait for system to stabilize, then reload Hyprland config
      # This triggers hyprdynamicmonitors to re-detect monitors
      ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 3 && ${pkgs.hyprland}/bin/hyprctl reload'";
    };
  };

  # System-level trigger to start the user service after resume
  systemd.services.hdmi-reset-trigger = {
    description = "Trigger HDMI reset for user sessions after resume";
    after = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
    ];
    wantedBy = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
    ];

    serviceConfig = {
      Type = "oneshot";
      # Find the primary user's UID and trigger their user service
      ExecStart = "${pkgs.bash}/bin/bash -c 'for uid in $(${pkgs.systemd}/bin/loginctl list-users --no-legend | ${pkgs.gawk}/bin/awk '\"'\"'{print $1}'\"'\"'); do ${pkgs.systemd}/bin/systemctl --user --machine=$uid@ start hdmi-reset-after-resume.service || true; done'";
    };
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

  hardware.graphics = {
    enable = true;
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
