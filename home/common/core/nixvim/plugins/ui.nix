# ui plugins
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # statusline
      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "auto";
            globalstatus = true;
            disabled_filetypes = {
              statusline = [
                "dashboard"
                "alpha"
                "ministarter"
                "snacks_dashboard"
              ];
            };
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" ];
            lualine_c = [
              {
                __unkeyed-1 = "diagnostics";
                symbols = {
                  error = " ";
                  warn = " ";
                  info = " ";
                  hint = " ";
                };
              }
              {
                __unkeyed-1 = "filetype";
                icon_only = true;
                separator = "";
                padding = {
                  left = 1;
                  right = 0;
                };
              }
              {
                __unkeyed-1 = "filename";
                path = 1;
              }
            ];
            lualine_x = [
              {
                __unkeyed-1.__raw = ''
                  function()
                    return require("noice").api.status.command.get()
                  end
                '';
                cond.__raw = ''
                  function()
                    return package.loaded["noice"] and require("noice").api.status.command.has()
                  end
                '';
                color.__raw = ''(function() return { fg = Snacks.util.color("Statement") } end)()'';
              }
              {
                __unkeyed-1.__raw = ''
                  function()
                    return require("noice").api.status.mode.get()
                  end
                '';
                cond.__raw = ''
                  function()
                    return package.loaded["noice"] and require("noice").api.status.mode.has()
                  end
                '';
                color.__raw = ''(function() return { fg = Snacks.util.color("Constant") } end)()'';
              }
              {
                __unkeyed-1.__raw = ''
                  function()
                    return "  " .. require("dap").status()
                  end
                '';
                cond.__raw = ''
                  function()
                    return package.loaded["dap"] and require("dap").status() ~= ""
                  end
                '';
                color.__raw = ''(function() return { fg = Snacks.util.color("Debug") } end)()'';
              }
              {
                __unkeyed-1 = "diff";
                symbols = {
                  added = " ";
                  modified = " ";
                  removed = " ";
                };
                source.__raw = ''
                  function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                      return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed,
                      }
                    end
                  end
                '';
              }
            ];
            lualine_y = [
              {
                __unkeyed-1 = "progress";
                separator = " ";
                padding = {
                  left = 1;
                  right = 0;
                };
              }
              {
                __unkeyed-1 = "location";
                padding = {
                  left = 0;
                  right = 1;
                };
              }
            ];
            lualine_z = [
              {
                __unkeyed-1.__raw = ''
                  function()
                    return " " .. os.date("%R")
                  end
                '';
              }
            ];
          };
          extensions = [
            "neo-tree"
            "lazy"
            "fzf"
          ];
        };
      };

      # buffer line
      bufferline = {
        enable = true;
        settings = {
          options = {
            close_command.__raw = "function(n) Snacks.bufdelete(n) end";
            right_mouse_command.__raw = "function(n) Snacks.bufdelete(n) end";
            diagnostics = "nvim_lsp";
            always_show_bufferline = false;
            diagnostics_indicator.__raw = ''
              function(_, _, diag)
                local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
                local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                  .. (diag.warning and icons.Warn .. diag.warning or "")
                return vim.trim(ret)
              end
            '';
            offsets = [
              {
                filetype = "neo-tree";
                text = "Neo-tree";
                highlight = "Directory";
                text_align = "left";
              }
              {
                filetype = "snacks_layout_box";
              }
            ];
            get_element_icon.__raw = ''
              function(elem)
                local icon, hl = require("mini.icons").get("filetype", elem.filetype)
                return icon, hl
              end
            '';
          };
        };
      };

      # better ui for messages, cmdline, and the popupmenu
      noice = {
        enable = true;
        settings = {
          lsp = {
            override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
              "cmp.entry.get_documentation" = true;
            };
          };
          routes = [
            {
              filter = {
                event = "msg_show";
                any = [
                  { find = "%d+L, %d+B"; }
                  { find = "; after #%d+"; }
                  { find = "; before #%d+"; }
                ];
              };
              view = "mini";
            }
          ];
          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
          };
        };
      };

      # icons
      mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          icons = { };
        };
      };

      # breadcrumbs
      navic = {
        enable = true;
        settings = {
          lsp = {
            auto_attach = true;
            preference = [
              "nil_ls"
              "lua_ls"
            ];
          };
          highlight = true;
          separator = " ";
          depth_limit = 5;
          icons = {
            File = "󰈙 ";
            Module = " ";
            Namespace = "󰌗 ";
            Package = " ";
            Class = "󰌗 ";
            Method = "󰆧 ";
            Property = " ";
            Field = " ";
            Constructor = " ";
            Enum = "󰕘";
            Interface = "󰕘";
            Function = "󰊕 ";
            Variable = "󰆧 ";
            Constant = "󰏿 ";
            String = "󰀬 ";
            Number = "󰎠 ";
            Boolean = "◩ ";
            Array = "󰅪 ";
            Object = "󰅩 ";
            Key = "󰌋 ";
            Null = "󰟢 ";
            EnumMember = " ";
            Struct = "󰌗 ";
            Event = " ";
            Operator = "󰆕 ";
            TypeParameter = "󰊄 ";
          };
        };
      };
    };

    keymaps = [
      # bufferline keymaps
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = "n";
        key = "[b";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "]b";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = "<Cmd>BufferLineTogglePin<CR>";
        options.desc = "Toggle Pin";
      }
      {
        mode = "n";
        key = "<leader>bP";
        action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
        options.desc = "Delete Non-Pinned Buffers";
      }
      {
        mode = "n";
        key = "<leader>br";
        action = "<Cmd>BufferLineCloseRight<CR>";
        options.desc = "Delete Buffers to the Right";
      }
      {
        mode = "n";
        key = "<leader>bl";
        action = "<Cmd>BufferLineCloseLeft<CR>";
        options.desc = "Delete Buffers to the Left";
      }
      {
        mode = "n";
        key = "[B";
        action = "<cmd>BufferLineMovePrev<cr>";
        options.desc = "Move Buffer Left";
      }
      {
        mode = "n";
        key = "]B";
        action = "<cmd>BufferLineMoveNext<cr>";
        options.desc = "Move Buffer Right";
      }
      # noice keymaps
      {
        mode = "n";
        key = "<leader>sn";
        action = "";
        options.desc = "+noice";
      }
      {
        mode = [
          "n"
          "i"
          "s"
        ];
        key = "<c-f>";
        action.__raw = ''
          function()
            if not require("noice.lsp").scroll(4) then
              return "<c-f>"
            end
          end
        '';
        options = {
          silent = true;
          expr = true;
          desc = "Scroll Forward";
        };
      }
      {
        mode = [
          "n"
          "i"
          "s"
        ];
        key = "<c-b>";
        action.__raw = ''
          function()
            if not require("noice.lsp").scroll(-4) then
              return "<c-b>"
            end
          end
        '';
        options = {
          silent = true;
          expr = true;
          desc = "Scroll Backward";
        };
      }
      {
        mode = "n";
        key = "<leader>snl";
        action = "<cmd>Noice last<cr>";
        options.desc = "Noice Last Message";
      }
      {
        mode = "n";
        key = "<leader>snh";
        action = "<cmd>Noice history<cr>";
        options.desc = "Noice History";
      }
      {
        mode = "n";
        key = "<leader>sna";
        action = "<cmd>Noice all<cr>";
        options.desc = "Noice All";
      }
      {
        mode = "n";
        key = "<leader>snd";
        action = "<cmd>Noice dismiss<cr>";
        options.desc = "Dismiss All";
      }
      {
        mode = "n";
        key = "<leader>snt";
        action.__raw = ''function() require("noice").cmd("pick") end'';
        options.desc = "Noice Picker (Telescope/FzfLua)";
      }
      {
        mode = "c";
        key = "<S-Enter>";
        action.__raw = ''function() require("noice").redirect(vim.fn.getcmdline()) end'';
        options.desc = "Redirect Cmdline";
      }
    ];
  };
}
