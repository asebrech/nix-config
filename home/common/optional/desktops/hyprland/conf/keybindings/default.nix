# Keybindings configuration selector
# Change the import to switch keybinding layouts
{ ... }:
{
  imports = [
    ./standard.nix # Default ML4W keybindings
    # ./custom.nix   # User custom keybindings
  ];
}
