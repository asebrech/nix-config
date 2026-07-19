{
  programs.ghostty = {
    enable = true;
  };

  # Ghostty as the default terminal (xdg-terminal-exec convention)
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/terminal" = [ "com.mitchellh.ghostty.desktop" ];
  };
}
