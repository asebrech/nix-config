# Mechabar styles base - Core waybar styles
# Adapted from github.com/sejjy/mechabar style.css
''
  /*===================
      BASE STYLES
  ===================*/

  * {
    all: initial;
    color: @base05;
  }

  .module {
    margin-bottom: -1px;
  }

  #waybar {
    background-color: transparent;
  }

  #waybar > box {
    margin: 4px;
    padding: 0;
    background-color: @base00;
  }

  button {
    border-radius: 16px;
    min-width: 16px;
    padding: 0 10px;
    background: transparent;
    border: none;
    color: @base05;
  }

  button:hover {
    background-color: @base01;
    color: alpha(@base05, 0.75);
  }

  tooltip {
    border: 2px solid @base04;
    border-radius: 10px;
    background-color: @base00;
    color: @base05;
  }

  tooltip > box {
    padding: 0 6px;
  }

  /* Dividers - powerline separators */
  #custom-left_div,
  #custom-left_inv,
  #custom-right_div,
  #custom-right_inv {
    font-weight: normal;
    background: transparent;
    padding: 0;
    margin: 0;
    min-width: 0;
  }
''
