{
  # Basic navigation (eza-powered)
  ls = "eza --icons=auto";
  ll = "eza -lh --icons=auto --git";
  la = "eza -lah --icons=auto --git";
  lt = "eza --tree --icons=auto";
  ".h" = "cd ~";

  # bat as cat: syntax highlighting, no pager
  cat = "bat --paging=never";

  # Tool shortcuts
  v = "hx"; # editor
  vi = "hx"; # muscle memory
  vim = "hx"; # muscle memory
  y = "yazi"; # file manager
  lg = "lazygit"; # git TUI
  j = "just"; # task runner
  top = "btop"; # system monitor
  du = "dust"; # disk usage
  df = "duf"; # filesystem usage

  # Nix commands
  nfc = "nix flake check";
  nb = "nix build";

  # Git aliases
  g = "git";
  ga = "git add";
  gs = "git status";
  gd = "git diff";
  gl = "git log";
  gp = "git push";
  gc = "git clone";
}
