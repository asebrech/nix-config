# Yanky.nvim - Better yank/paste
{ ... }:
{
  programs.nixvim = {
    plugins.yanky = {
      enable = true;
      settings = {
        ring = {
          history_length = 100;
          storage = "shada";
          sync_with_numbered_registers = true;
          cancel_event = "update";
          ignore_registers = [ "_" ];
        };
        picker = {
          select = {
            action = null; # nil = default put action
          };
          telescope = {
            use_default_mappings = true;
            mappings = null; # nil = default mappings
          };
        };
        system_clipboard = {
          sync_with_ring = true;
        };
        preserve_cursor_position = {
          enabled = true;
        };
        highlight = {
          on_put = true;
          on_yank = true;
          timer = 500;
        };
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "x"
        ];
        key = "p";
        action = "<Plug>(YankyPutAfter)";
        options.desc = "Put Text After Cursor";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "P";
        action = "<Plug>(YankyPutBefore)";
        options.desc = "Put Text Before Cursor";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "gp";
        action = "<Plug>(YankyGPutAfter)";
        options.desc = "Put Text After Selection";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "gP";
        action = "<Plug>(YankyGPutBefore)";
        options.desc = "Put Text Before Selection";
      }
      {
        mode = "n";
        key = "<c-p>";
        action = "<Plug>(YankyPreviousEntry)";
        options.desc = "Select Previous Entry";
      }
      {
        mode = "n";
        key = "<c-n>";
        action = "<Plug>(YankyNextEntry)";
        options.desc = "Select Next Entry";
      }
      {
        mode = "n";
        key = "]p";
        action = "<Plug>(YankyPutIndentAfterLinewise)";
        options.desc = "Put Indented After Cursor (Linewise)";
      }
      {
        mode = "n";
        key = "[p";
        action = "<Plug>(YankyPutIndentBeforeLinewise)";
        options.desc = "Put Indented Before Cursor (Linewise)";
      }
      {
        mode = "n";
        key = "]P";
        action = "<Plug>(YankyPutIndentAfterLinewise)";
        options.desc = "Put Indented After Cursor (Linewise)";
      }
      {
        mode = "n";
        key = "[P";
        action = "<Plug>(YankyPutIndentBeforeLinewise)";
        options.desc = "Put Indented Before Cursor (Linewise)";
      }
      {
        mode = "n";
        key = "<leader>sy";
        action.__raw = ''
          function()
            require("telescope").extensions.yank_history.yank_history({})
          end
        '';
        options.desc = "Open Yank History";
      }
    ];
  };
}
