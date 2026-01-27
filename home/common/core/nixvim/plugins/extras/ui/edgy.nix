# Edgy.nvim - Manage window layouts
{ ... }:
{
  programs.nixvim = {
    plugins.edgy = {
      enable = true;

      settings = {
        bottom = [
          { ft = "toggleterm"; }
          { ft = "trouble"; }
          {
            ft = "qf";
            title = "QuickFix";
          }
          { ft = "help"; }
          { ft = "spectre_panel"; }
        ];

        left = [
          { ft = "neo-tree"; }
        ];

        right = [
          { ft = "Outline"; }
        ];

        options = {
          left = {
            size = 30;
          };
          bottom = {
            size = 10;
          };
          right = {
            size = 30;
          };
          top = {
            size = 10;
          };
        };

        animate = {
          enabled = false;
        };

        exit_when_last = false;
        close_when_all_hidden = true;

        wo = {
          winbar = true;
          winfixwidth = true;
          winfixheight = false;
          spell = false;
          signcolumn = "no";
        };

        icons = {
          closed = ">";
          open = "v";
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ue";
        action.__raw = ''
          function()
            require("edgy").toggle()
          end
        '';
        options.desc = "Toggle Edgy";
      }
      {
        mode = "n";
        key = "<leader>uE";
        action.__raw = ''
          function()
            require("edgy").select()
          end
        '';
        options.desc = "Edgy Select Window";
      }
    ];
  };
}
