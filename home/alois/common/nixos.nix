# User-specific NixOS configurations for alois
{ config, lib, ... }:
let
  home = config.home.homeDirectory;
in
{
  home = {
    sessionPath = lib.flatten ([
      "${home}/scripts/"
    ]);
  };
}
