{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = [
    pkgs.fzf # fuzzy finder
  ];

  programs.zsh = {
    enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    history.size = 10000;
    history.share = true;

    # NOTE: syntax highlighting and autosuggestions are enabled natively
    # above; only load plugins here that HM has no option for
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-history-substring-search"
      ];
    };

    plugins = import ./plugins.nix;

    initContent = lib.mkAfter (lib.readFile ./zshrc);

    shellAliases = import ./aliases.nix;
  };
}
