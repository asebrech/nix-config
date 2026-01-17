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
    initrd.systemd.enable = lib.mkDefault true;
  };

  # Increase configuration limit when using plymouth
  # (initrd can expand significantly with themes)
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
}
