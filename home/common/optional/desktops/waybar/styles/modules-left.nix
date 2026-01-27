# Mechabar styles/modules-left.css - Left module styles
# Adapted from github.com/sejjy/mechabar
''
  /*===================
      LEFT MODULES
  ===================*/

  /*--------------
      trigger
  --------------*/

  #custom-trigger {
    color: @base05;
    padding: 0 4px;
  }

  /*--------------
      username
  --------------*/

  #custom-user {
    padding-right: 12px;
    color: @base05;
  }

  /*----------------
      workspaces
  ----------------*/

  #custom-left_div.1,
  #custom-right_div.1 {
    color: @base02;
  }

  #workspaces {
    padding: 0 1px;
    background-color: @base02;
  }

  #workspaces button {
    padding: 0 6px;
    background: transparent;
    border: none;
    border-radius: 0;
    box-shadow: none;
  }

  #workspaces button.active,
  #workspaces button.focused {
    background: transparent;
    border: none;
    box-shadow: none;
  }

  #workspaces button.active label,
  #workspaces button.focused label {
    color: @base0D;
  }

  /*------------------
      window title
  ------------------*/

  #window {
    margin-left: 12px;
    color: @base05;
  }
''
