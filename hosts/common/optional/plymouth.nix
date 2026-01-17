{
  lib,
  ...
}:
{
  boot = {
    kernelParams = [
      "quiet" # Reduce kernel output during boot
      "splash" # Enable splash screen
    ];

    plymouth = {
      enable = true;
      # Theme will be automatically set by Stylix
    };

    # Reduce console log level for cleaner boot
    consoleLogLevel = 0;

    # Enable systemd in initrd for better plymouth integration
    initrd.systemd.enable = lib.mkDefault true;
  };

  # Increase configuration limit when using plymouth
  # (initrd can expand significantly with themes)
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
}
