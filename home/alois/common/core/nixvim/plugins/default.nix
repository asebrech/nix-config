# LazyVim plugins module - combines all plugin files
{ ... }:
{
  imports = [
    # Core plugins (always loaded)
    ./init.nix
    ./coding.nix
    ./colorscheme.nix
    ./editor.nix
    ./formatting.nix
    ./linting.nix
    ./lsp
    ./treesitter.nix
    ./ui.nix
    ./util.nix

    # Extras (optional, comment out what you don't need)
    ./extras
  ];
}
