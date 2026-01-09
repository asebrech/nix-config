{ ... }:
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "sleep 1; hyprlock";
        text = "[l]ock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "sleep 1; hyprctl dispatch exit";
        text = "[e]xit";
        keybind = "e";
      }
      {
        label = "reboot";
        action = "sleep 1; systemctl reboot";
        text = "[r]eboot";
        keybind = "r";
      }
      {
        label = "suspend";
        action = "sleep 1; systemctl suspend";
        text = "s[u]spend";
        keybind = "u";
      }
      {
        label = "hibernate";
        action = "sleep 1; systemctl hibernate";
        text = "[h]ibernate";
        keybind = "h";
      }
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "[s]hutdown";
        keybind = "s";
      }
    ];
    style = ''
      * {
        font-family: "FiraCode Nerd Font", sans-serif;
        background-image: none;
        transition: 20ms;
      }
    '';
  };
}
