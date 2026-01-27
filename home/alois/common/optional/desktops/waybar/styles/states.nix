# Mechabar styles/states.css - Module state styles
# Adapted from github.com/sejjy/mechabar
''
  /*===================
      STATES
  ===================*/

  /*--------------
      hover
  --------------*/

  #custom-trigger:hover,
  #idle_inhibitor:hover,
  #clock.date:hover,
  #network:hover,
  #bluetooth:hover,
  #custom-system_update:hover,
  #mpris:hover,
  #pulseaudio:hover,
  #wireplumber:hover {
    color: alpha(@base05, 0.75);
  }

  /*--------------
      inactive
  --------------*/

  /* idle_inhibitor uses different icons for states, no color change needed */

  #mpris.paused,
  #pulseaudio.output.muted,
  #pulseaudio.input.source-muted,
  #wireplumber.muted {
    color: @base04;
  }

  /*--------------
      warning
  --------------*/

  #memory.warning,
  #cpu.warning,
  #battery.warning {
    color: @base0A;
  }

  /*--------------
      critical
  --------------*/

  #temperature.critical,
  #memory.critical,
  #cpu.critical,
  #battery.critical {
    color: @base08;
  }

  /*--------------
      charging
  --------------*/

  #battery.charging {
    color: @base0B;
  }
''
