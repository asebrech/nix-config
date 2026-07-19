{ lib, pkgs, ... }:
{
  imports = [
    ./niri
    ./noctalia.nix
  ];

  home.packages = lib.attrValues {
    inherit (pkgs)
      cliphist # clipboard history backend for the noctalia launcher
      pavucontrol # audio mixer, opened by the noctalia volume widget
      brightnessctl # backlight control fallback
      ;
  };
}
