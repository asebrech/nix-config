{ ... }:
{
  imports = [
    #
    # ========== Required Configs ==========
    #
    common/core

    #
    # ========== Host-specific Optional Configs ==========
    #
    common/optional/browsers
    common/optional/comms
    common/optional/desktops
    common/optional/media
    common/optional/reverse-engineering.nix
    common/optional/tmux
    common/optional/opencode.nix
    common/optional/claude-code.nix

    common/optional/sops.nix
  ];
}
