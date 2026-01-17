{
  lib,
  ...
}:
{
  boot = {
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
    ];

    plymouth = {
      enable = true;
      # Let Stylix handle theming automatically
    };

    # Enable "Silent Boot"
    consoleLogLevel = 3;
    initrd.verbose = false;

    # Enable systemd in initrd for better plymouth integration
    # Required for Plymouth to work properly
    initrd.systemd.enable = true;

    # Hide bootloader menu (press any key during boot to show it)
    loader.timeout = lib.mkDefault 0;
  };

  # Increase configuration limit when using plymouth
  # (initrd can expand significantly with themes)
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
}
