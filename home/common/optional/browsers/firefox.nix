{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    # Keep the pre-26.05 profile location so the existing profile keeps working
    configPath = ".mozilla/firefox";
  };
}
