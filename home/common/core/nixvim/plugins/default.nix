# plugins
{ ... }:
{
  imports = [
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
    ./extras
  ];
}
