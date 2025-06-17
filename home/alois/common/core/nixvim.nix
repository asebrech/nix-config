{
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    # nixpkgs.pkgs = import <nixpkgs> { };

    enable = true;

  };
}
