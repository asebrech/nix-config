# ML4W window rules adapted for NixOS
# Based on: https://github.com/mylinuxforwork/dotfiles

[
  # Floating windows
  "float, class:(pavucontrol)"
  "float, class:(org.pulseaudio.pavucontrol)"
  "float, class:(blueman-manager)"
  "float, class:(nm-connection-editor)"
  "float, class:(galculator)"
  "float, class:(org.gnome.Calculator)"
  "float, class:(nwg-look)"
  "float, class:(nwg-displays)"
  "float, title:(Picture-in-Picture)"
  "float, title:^(Picture-in-Picture)$"

  # Centered floating windows
  "center, class:(pavucontrol)"
  "center, class:(blueman-manager)"
  "center, class:(nm-connection-editor)"
  "center, class:(galculator)"

  # Pinned windows
  "pin, title:^(Picture-in-Picture)$"

  # Window sizes
  "size 700 600, class:(pavucontrol)"
  "size 800 600, class:(blueman-manager)"
  "size 800 700, class:(nm-connection-editor)"
  "size 25% 25%, title:^(Picture-in-Picture)$"

  # Window positioning
  "move 72% 7%, title:^(Picture-in-Picture)$"

  # Opacity rules
  "opacity 0.9 0.9, class:(thunar)"
  "opacity 0.9 0.9, class:(Alacritty)"
  "opacity 0.9 0.9, class:(alacritty)"

  # Idle inhibit for media
  "idleinhibit fullscreen, class:(firefox)"
  "idleinhibit fullscreen, class:(mpv)"
  "idleinhibit fullscreen, class:(vlc)"

  # XWayland video bridge
  "opacity 0.0 override, class:^(xwaylandvideobridge)$"
  "noanim, class:^(xwaylandvideobridge)$"
  "noinitialfocus, class:^(xwaylandvideobridge)$"
  "maxsize 1 1, class:^(xwaylandvideobridge)$"
  "noblur, class:^(xwaylandvideobridge)$"
]
