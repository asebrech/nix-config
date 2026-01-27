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

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-history-substring-search"
      ];
    };

    plugins = import ./plugins.nix;

    initContent = lib.mkAfter (lib.readFile ./zshrc);

    shellAliases = import ./aliases.nix;
  };
}
