# User-specific NixOS configurations for exampleSecondUser
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
