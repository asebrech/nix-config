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

  # Smarter cd: `z <keyword>` jumps to frecent directories
  programs.zoxide.enable = true;

  # Typo'd a command? `f` suggests and reruns the fixed version
  # (maintained Rust successor of thefuck)
  programs.pay-respects.enable = true;

  # Searchable shell history database on Ctrl+R (local only)
  programs.atuin.enable = true;

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
