# Declarative COSMIC settings via cosmic-manager.
# Scope is deliberately minimal: only the handful of settings we actually
# changed from the defaults in COSMIC Settings. Everything declared here
# becomes owned by home-manager (changing it in the Settings app will be
# reverted on the next rebuild); everything else stays freely configurable
# in the GUI.
{ inputs, ... }:
{
  imports = [ inputs.cosmic-manager.homeManagerModules.cosmic-manager ];

  wayland.desktopManager.cosmic = {
    enable = true;

    # Dark theme
    appearance.theme.mode = "dark";

    # Panel clock: 24h format, week starts on Sunday (COSMIC default)
    applets.time.settings = {
      military_time = true;
      first_day_of_week = 6;
    };

    # Auto-tiling on, toggleable per workspace
    compositor = {
      autotile = true;
      autotile_behavior = {
        __type = "enum";
        variant = "PerWorkspace";
      };
    };

    # Never auto-suspend on AC power: suspending while docked breaks the
    # external display until the lid is opened (Asahi DCP resume issue,
    # https://github.com/AsahiLinux/linux/issues/430). Battery behavior
    # keeps the COSMIC default.
    idle = {
      suspend_on_ac_time = {
        __type = "optional";
        value = null;
      };
    };
  };
}
