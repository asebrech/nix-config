# Claude Code AI coding agent
# https://github.com/anthropics/claude-code
# Using ryoppippi/nix-claude-code flake for latest versions
{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.claude-code.packages.${pkgs.system}.default
  ];
}
