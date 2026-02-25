# nixvim
# ported from lazyvim commit c64a61734fc9d45470a72603395c02137802bc6f (v15.13.0)
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
