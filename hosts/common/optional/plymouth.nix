{
  lib,
  pkgs,
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

      # Use hexagon_hud theme from adi1090x collection
      theme = "hexagon_hud";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ "hexagon_hud" ];
        })
      ];
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
