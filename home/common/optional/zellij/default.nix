{

  pkgs,
  ...
}:
{
  programs.zellij = {
    enable = true;
    package = pkgs.unstable.zellij;
  };

  programs.zsh = {
    shellAliases = {
      zl = "zellij";
      zls = "zellij list-sessions";
      zla = "zellij attach";
    };
  };
}
