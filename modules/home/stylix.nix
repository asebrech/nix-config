{
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.hostSpec.isAutoStyled {
    stylix = {
      # Enable user-specific Stylix targets
      targets = {
        # Terminal emulators
        alacritty.enable = true;
        kitty.enable = lib.mkDefault false; # Disable if not used
        ghostty.enable = lib.mkDefault true;

        # Shell
        zsh.enable = true;
        bash.enable = true;

        # Terminal multiplexer
        # zellij.enable = lib.mkDefault true; # Enable if using zellij

        # Text editors
        vim.enable = true;
        neovim.enable = lib.mkDefault false; # Enable if using neovim

        # File managers
        # lf.enable = lib.mkDefault true; # Enable if using lf

        # Browsers
        firefox.enable = lib.mkDefault true;

        # Communication
        # discord.enable = lib.mkDefault true; # Enable if using Discord

        # System tools
        btop.enable = lib.mkDefault true;

        # Rofi
        rofi.enable = true;

        # Hyprland (inherits from system but can be overridden here)
        hyprland.enable = true;

        # Waybar
        waybar.enable = true;

        # Notifications
        dunst.enable = true;

        # GTK
        gtk.enable = true;
      };
    };
  };
}
