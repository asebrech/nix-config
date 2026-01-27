# LazyVim-style configuration for nixvim
# Theming is handled by stylix
{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./config
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
