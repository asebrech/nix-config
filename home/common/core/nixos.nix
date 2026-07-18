# Core home functionality that will only work on Linux
{
  pkgs,
  lib,
  ...
}:
{
  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        trash-cli # tools for managing trash
        ;
    };

    sessionVariables = {
      VISUAL = "hx";
      EDITOR = "hx";
    };
  };
}
