# OpenCode AI coding agent
# https://github.com/anomalyco/opencode
{ pkgs, ... }:
{
  programs.opencode = {
    enable = true;
    package = pkgs.unstable.opencode;
    settings = {
      "$schema" = "https://opencode.ai/config.json"; # This line is required!
    };
  };

  programs.zsh.shellAliases = {
    oc = "opencode";
  };
}
