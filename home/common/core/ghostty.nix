{
  programs.ghostty = {
    enable = true;
  };

  # Ghostty as the default terminal (xdg-terminal-exec convention,
  # used by the COSMIC "Default Apps" terminal entry)
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/terminal" = [ "com.mitchellh.ghostty.desktop" ];
  };
}
