# Zen browser (Firefox-based), hardened to roughly Brave-level privacy but
# kept alongside Brave (Brave stays the default browser). Balanced hardening
# via the Betterfox preset (telemetry/privacy prefs, no breaking
# resistFingerprinting) plus uBlock Origin. Theming comes from stylix (its
# zen-browser target), so Zen follows the catppuccin-mocha base16 palette
# like everything else.
{ inputs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.default ];

  # stylix themes the browser chrome; point its target at our profile.
  stylix.targets.zen-browser.profileNames = [ "default" ];

  programs.zen-browser = {
    enable = true;
    # Brave remains the default browser; Zen is added alongside.
    setAsDefaultBrowser = false;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      # uBlock Origin, force-installed from AMO
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.default = {
      # Betterfox for Zen: balanced privacy/telemetry hardening (no RFP)
      presets.betterfox.enable = true;
      # Brave-parity extras Betterfox leaves as a user choice
      settings = {
        "dom.security.https_only_mode" = true;
        "network.trr.mode" = 2; # DNS-over-HTTPS, with fallback
        # Active fingerprint randomization (Firefox FPP) — closes the gap to
        # Brave's farbling without the breakage of full resistFingerprinting
        "privacy.fingerprintingProtection" = true;

        # Skip first-run onboarding / welcome screens
        "zen.welcome-screen.seen" = true;
        "browser.aboutwelcome.enabled" = false;
        "browser.startup.homepage_override.mstone" = "ignore"; # no "what's new" on update
        "browser.messaging-system.whatsNewPanel.enabled" = false;
      };
      # DuckDuckGo as the default search engine (privacy-respecting)
      search = {
        force = true; # enforce on each rebuild
        default = "ddg";
      };
    };
  };
}
