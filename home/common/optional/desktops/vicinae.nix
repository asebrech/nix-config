# vicinae: the app launcher, bound to Mod+Space in niri (replacing the
# noctalia launcher, see niri/config.kdl). Using the home-manager module
# (rather than the raw package) means stylix themes it automatically via
# its built-in vicinae target — the colors follow the stylix base16 theme.
# The server runs as a user service started with the graphical session.
{ ... }:
{
  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
  };
}
