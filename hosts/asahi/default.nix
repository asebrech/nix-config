{
  config,
  lib,
  ...
}:
{
  imports = lib.flatten [
    #
    # ========== Hardware ==========
    #
    ./hardware-configuration.nix
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

          # Desktop and Window Manager
          "hyprland.nix" # hyprland window manager
          "wayland.nix" # wayland packages
          "plymouth.nix" # boot splash screen

          # System
          "audio.nix" # pipewire and cli controls
          "thunar.nix" # thunar file manager with plugins
        ])
    ))
  ];

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
    scaling = "1.5"; # 4K display scaling (150% - more screen space)
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

  boot.loader = {
    systemd-boot = {
      enable = true;
      # When using plymouth, initrd can expand by a lot each time, so limit how many we keep around
      configurationLimit = lib.mkDefault 10;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
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
