# ML4W window rules
# Adapted for NixOS - minimal set

[
  # Floating windows
  "float, class:(pavucontrol)"
  "float, class:(blueman-manager)"
  "float, class:(nm-connection-editor)"
  "float, class:(galculator)"
  "float, title:(Picture-in-Picture)"

  # Opacity rules
  "opacity 0.9 0.9, class:(thunar)"
  "opacity 0.9 0.9, class:(Alacritty)"

  # Workspace assignments
  "workspace 2 silent, class:(firefox)"
  "workspace 3 silent, class:(thunar)"

  # Idle inhibit for media
  "idleinhibit fullscreen, class:(firefox)"
  "idleinhibit fullscreen, class:(mpv)"

  # Picture-in-picture
  "float, title:^(Picture-in-Picture)$"
  "pin, title:^(Picture-in-Picture)$"
  "size 25% 25%, title:^(Picture-in-Picture)$"
  "move 72% 7%, title:^(Picture-in-Picture)$"
]
