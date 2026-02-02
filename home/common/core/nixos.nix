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

    # Reload font cache on rebuild to avoid font issues
    activation.reloadFontCache = lib.hm.dag.entryAfter [ "linkActivation" ] ''
      if [ -x "${pkgs.fontconfig}/bin/fc-cache" ]; then
        ${pkgs.fontconfig}/bin/fc-cache -f
      fi
    '';

    sessionVariables = {
      FLAKE = "$HOME/nix-config";
      SHELL = "zsh";
      TERM = "alacritty";
      TERMINAL = "alacritty";
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
  };
}
