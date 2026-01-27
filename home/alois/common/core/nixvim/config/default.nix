# LazyVim config module - combines all config files
{ ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
  ];
}
