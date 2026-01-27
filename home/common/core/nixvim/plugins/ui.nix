# LazyVim plugins/ui.nix - UI plugins
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # Lualine - Statusline
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
                color = {
                  fg = "#ff9e64";
                };
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
                color = {
                  fg = "#ff9e64";
                };
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
                color = {
                  fg = "#ff9e64";
                };
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
          ];
        };
      };

      # Bufferline - Buffer tabs
      bufferline = {
        enable = true;
        settings = {
          options = {
            close_command.__raw = ''function(n) Snacks.bufdelete(n) end'';
            right_mouse_command.__raw = ''function(n) Snacks.bufdelete(n) end'';
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
            ];
            get_element_icon.__raw = ''
              function(elem)
                local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(elem.filetype, { default = false })
                return icon, hl
              end
            '';
          };
        };
      };

      # Noice - Better UI for messages, cmdline, popupmenu
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
            lsp_doc_border = true;
          };
        };
      };

      # Mini.icons
      mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          icons = { };
        };
      };

      # Dressing - Better UI for inputs and selects
      dressing = {
        enable = true;
        settings = { };
      };

      # Indent blankline - Indentation guides
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
            tab_char = "│";
          };
          scope = {
            show_start = false;
            show_end = false;
          };
          exclude = {
            filetypes = [
              "help"
              "alpha"
              "dashboard"
              "neo-tree"
              "Trouble"
              "trouble"
              "lazy"
              "mason"
              "notify"
              "toggleterm"
              "lazyterm"
            ];
          };
        };
      };

      # Navic - Breadcrumbs
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
      # Bufferline
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
      # Noice
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
        action.__raw = ''function() require("noice").cmd("last") end'';
        options.desc = "Noice Last Message";
      }
      {
        mode = "n";
        key = "<leader>snh";
        action.__raw = ''function() require("noice").cmd("history") end'';
        options.desc = "Noice History";
      }
      {
        mode = "n";
        key = "<leader>sna";
        action.__raw = ''function() require("noice").cmd("all") end'';
        options.desc = "Noice All";
      }
      {
        mode = "n";
        key = "<leader>snd";
        action.__raw = ''function() require("noice").cmd("dismiss") end'';
        options.desc = "Dismiss All";
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
