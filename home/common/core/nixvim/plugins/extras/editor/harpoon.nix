# Harpoon - Quick file navigation
{ ... }:
{
  programs.nixvim = {
    plugins.harpoon = {
      enable = true;
      enableTelescope = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>H";
        action.__raw = ''
          function()
            require("harpoon"):list():add()
          end
        '';
        options.desc = "Harpoon File";
      }
      {
        mode = "n";
        key = "<leader>h";
        action.__raw = ''
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end
        '';
        options.desc = "Harpoon Quick Menu";
      }
      {
        mode = "n";
        key = "<leader>1";
        action.__raw = ''
          function()
            require("harpoon"):list():select(1)
          end
        '';
        options.desc = "Harpoon to File 1";
      }
      {
        mode = "n";
        key = "<leader>2";
        action.__raw = ''
          function()
            require("harpoon"):list():select(2)
          end
        '';
        options.desc = "Harpoon to File 2";
      }
      {
        mode = "n";
        key = "<leader>3";
        action.__raw = ''
          function()
            require("harpoon"):list():select(3)
          end
        '';
        options.desc = "Harpoon to File 3";
      }
      {
        mode = "n";
        key = "<leader>4";
        action.__raw = ''
          function()
            require("harpoon"):list():select(4)
          end
        '';
        options.desc = "Harpoon to File 4";
      }
      {
        mode = "n";
        key = "<leader>5";
        action.__raw = ''
          function()
            require("harpoon"):list():select(5)
          end
        '';
        options.desc = "Harpoon to File 5";
      }
    ];
  };
}
