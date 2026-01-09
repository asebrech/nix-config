{ ... }:
{
  wayland.windowManager.hyprland.settings = {

    #
    # ========== Layer Rules ==========
    #
    layer = [
      #"blur, rofi"
      #"ignorezero, rofi"
      #"ignorezero, logout_dialog"

    ];

    #
    # ========== layout rules ==========
    #
    dwindle = {
      preserve_split = true;
      pseudotile = true;
    };

    #
    # ========== Window Rules ==========
    #
    windowrule = [
      #
      # ========== Workspace Assignments ==========
      #
      # to determine class and title for all active windows, run `hyprctl clients`
      "match:class ^(brave-browser)$, workspace 2"
      "match:class ^(firefox)$, workspace 2"
      "match:class ^(signal)$, workspace 3"
      "match:class ^(discord)$, workspace 3"
      "match:class ^(spotify)$, workspace 4"

      #
      # ========== Tile on at launch ==========
      #
      # Examples...

      #
      # ========== float on at launch ==========
      #
      "match:class ^(galculator)$, float on"
      "match:class ^(waypaper)$, float on"

      # Dialog windows
      "match:title ^(Open File)(.*)$, float on"
      "match:title ^(Select a File)(.*)$, float on"
      "match:title ^(Choose wallpaper)(.*)$, float on"
      "match:title ^(Open Folder)(.*)$, float on"
      "match:title ^(Save As)(.*)$, float on"
      "match:title ^(Library)(.*)$, float on"
      "match:title ^(Accounts)(.*)$, float on"
      "match:title ^(Text Import)(.*)$, float on"
      "match:title ^(File Operation Progress)(.*)$, float on"
      "match:title ^()$, match:class ^([Ff]irefox), float on, no_initial_focus on"

      #
      # ========== Always opaque ==========
      #
      "match:class ^([Gg]imp)$, opaque on"
      "match:class ^([Ff]lameshot)$, opaque on"
      "match:class ^([Ii]nkscape)$, opaque on"
      "match:class ^([Bb]lender)$, opaque on"
      "match:class ^([Vv]lc)$, opaque on"
      "match:title ^(btop)(.*)$, opaque on"

      # Remove transparency from video
      "match:title ^(Netflix)(.*)$, opaque on"
      "match:title ^(.*YouTube.*)$, opaque on"
      "match:title ^(Picture-in-Picture)$, opaque on"

    ];
  };
}
