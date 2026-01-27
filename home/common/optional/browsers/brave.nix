{ pkgs, ... }:
{
  # Set Brave as default browser
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "brave-browser.desktop" ];
    "x-scheme-handler/http" = [ "brave-browser.desktop" ];
    "x-scheme-handler/https" = [ "brave-browser.desktop" ];
    "x-scheme-handler/about" = [ "brave-browser.desktop" ];
    "x-scheme-handler/unknown" = [ "brave-browser.desktop" ];
  };

  programs.brave = {
    enable = true;
    package = pkgs.unstable.brave;
    commandLineArgs = [
      "--no-default-browser-check"
      "--restore-last-session"
      "--password-store=basic" # Disable built-in password manager prompts
      "--disable-features=PasswordManager,WaylandWpColorManagerV1"
    ];
    extensions = [
      # Proton Pass extension ID
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass
    ];
  };
}
