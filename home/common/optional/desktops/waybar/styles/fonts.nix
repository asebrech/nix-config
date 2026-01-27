# Mechabar styles/fonts.css - Font overrides
# Stylix handles base font configuration automatically
# We only add mechabar-specific size/weight overrides
''
  /*===================
      FONT OVERRIDES
      (Stylix provides base font-family)
  ===================*/

  * {
    font-weight: bold;
    font-size: 16px;
  }

  #custom-user,
  #window label,
  #mpris,
  tooltip label {
    font-weight: normal;
  }

  #workspaces button.active label,
  #workspaces button.focused label,
  #custom-distro {
    font-size: 20px;
  }

  #custom-power_menu,
  #custom-notifications {
    font-size: 18px;
  }

  #custom-left_div,
  #custom-left_inv,
  #custom-right_div,
  #custom-right_inv {
    font-size: 22px;
  }
''
