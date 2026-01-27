{
  ...
}:
{
  boot = {
    plymouth.enable = true;

    # Standard silent boot configuration
    consoleLogLevel = 3;
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "splash"
    ];

    # Enable systemd in initrd (recommended for Plymouth)
    initrd.systemd.enable = true;
  };
}
