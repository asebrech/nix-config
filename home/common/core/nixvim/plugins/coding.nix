# coding plugins
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # completion engine
      blink-cmp = {
        enable = true;
        settings = {
          snippets = {
            preset = "default";
          };
          appearance = {
            use_nvim_cmp_as_default = false;
            nerd_font_variant = "mono";
          };
          completion = {
            accept = {
              auto_brackets.enabled = true;
            };
            menu = {
              draw = {
                treesitter = [ "lsp" ];
              };
            };
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 200;
            };
            ghost_text.enabled.__raw = "vim.g.ai_cmp";
          };
          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
            ];
            per_filetype = {
              lua = {
                __raw = ''{ inherit_defaults = true, "lazydev" }'';
              };
            };
            providers = {
              lazydev = {
                name = "LazyDev";
                module = "lazydev.integrations.blink";
                score_offset = 100;
              };
            };
          };
          cmdline = {
            enabled = true;
            keymap = {
              preset = "cmdline";
              "<Right>".__raw = "false";
              "<Left>".__raw = "false";
            };
            completion = {
              list.selection.preselect = false;
              menu.auto_show.__raw = ''
                function(ctx)
                  return vim.fn.getcmdtype() == ":"
                end
              '';
              ghost_text.enabled = true;
            };
          };
          keymap = {
            preset = "enter";
            "<C-y>" = [ "select_and_accept" ];
          };
        };
      };

      # snippets
      friendly-snippets.enable = true;

      # treesitter-aware commenting
      ts-comments = {
        enable = true;
        settings = { };
      };

      # todo comments
      todo-comments = {
        enable = true;
        settings = {
          signs = true;
          keywords = {
            FIX = {
              icon = " ";
              color = "error";
              alt = [
                "FIXME"
                "BUG"
                "FIXIT"
                "ISSUE"
              ];
            };
            TODO = {
              icon = " ";
              color = "info";
            };
            HACK = {
              icon = " ";
              color = "warning";
            };
            WARN = {
              icon = " ";
              color = "warning";
              alt = [
                "WARNING"
                "XXX"
              ];
            };
            PERF = {
              icon = " ";
              alt = [
                "OPTIM"
                "PERFORMANCE"
                "OPTIMIZE"
              ];
            };
            NOTE = {
              icon = " ";
              color = "hint";
              alt = [ "INFO" ];
            };
            TEST = {
              icon = "⏲ ";
              color = "test";
              alt = [
                "TESTING"
                "PASSED"
                "FAILED"
              ];
            };
          };
        };
      };

      # mini.ai, mini.pairs, mini.surround
      mini = {
        enable = true;
        modules = {
          ai = {
            n_lines = 500;
            custom_textobjects = {
              # code block
              o = {
                __raw = ''
                  require('mini.ai').gen_spec.treesitter({
                    a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                  }, {})
                '';
              };
              # function
              f = {
                __raw = ''
                  require('mini.ai').gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {})
                '';
              };
              # class
              c = {
                __raw = ''
                  require('mini.ai').gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {})
                '';
              };
              # tags
              t = [
                "<([%p%w]-)%f[^<%w][^<>]->.-</%1>"
                "^<.->().*()</[^/]->$"
              ];
              # digits
              d = [ "%f[%d]%d+" ];
              # word with case
              e = {
                __raw = ''
                  {
                    {
                      "%u[%l%d]+%f[^%l%d]",
                      "%f[%S][%l%d]+%f[^%l%d]",
                      "%f[%P][%l%d]+%f[^%l%d]",
                      "^[%l%d]+%f[^%l%d]",
                    },
                    "^().*()$",
                  }
                '';
              };
              # buffer
              g = {
                __raw = ''
                  function(ai_type)
                    local start_line, end_line = 1, vim.fn.line("$")
                    if ai_type == "i" then
                      local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
                      if first_nonblank == 0 or last_nonblank == 0 then
                        return { from = { line = start_line, col = 1 } }
                      end
                      start_line, end_line = first_nonblank, last_nonblank
                    end
                    local to_col = math.max(vim.fn.getline(end_line):len(), 1)
                    return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
                  end
                '';
              };
              # u for "Usage"
              u = {
                __raw = "require('mini.ai').gen_spec.function_call()";
              };
              # without dot in function name
              U = {
                __raw = ''require('mini.ai').gen_spec.function_call({ name_pattern = "[%w_]" })'';
              };
            };
          };
          pairs = {
            modes = {
              insert = true;
              command = true;
              terminal = false;
            };
          };
          surround = {
            mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";
            };
          };
        };
      };

      # configures LuaLS for neovim config development
      lazydev = {
        enable = true;
        settings = {
          library = [
            {
              path = "\${3rd}/luv/library";
              words = [ "vim%.uv" ];
            }
            {
              path = "snacks.nvim";
              words = [ "Snacks" ];
            }
          ];
        };
      };
    };

    # todo-comments keymaps
    keymaps = [
      {
        mode = "n";
        key = "]t";
        action.__raw = ''function() require("todo-comments").jump_next() end'';
        options.desc = "Next Todo Comment";
      }
      {
        mode = "n";
        key = "[t";
        action.__raw = ''function() require("todo-comments").jump_prev() end'';
        options.desc = "Previous Todo Comment";
      }
      {
        mode = "n";
        key = "<leader>xt";
        action = "<cmd>Trouble todo toggle<cr>";
        options.desc = "Todo (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xT";
        action = "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>";
        options.desc = "Todo/Fix/Fixme (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>st";
        action = "<cmd>TodoTelescope<cr>";
        options.desc = "Todo";
      }
      {
        mode = "n";
        key = "<leader>sT";
        action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>";
        options.desc = "Todo/Fix/Fixme";
      }
    ];

    # mini.pairs custom open() wrapper with skip logic
    extraConfigLua = ''
      -- mini.pairs
      do
        local pairs = require("mini.pairs")
        local open = pairs.open
        local opts = {
          skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
          skip_ts = { "string" },
          skip_unbalanced = true,
          markdown = true,
        }
        pairs.open = function(pair, neigh_pattern)
          if vim.fn.getcmdline() ~= "" then
            return open(pair, neigh_pattern)
          end
          local o, c = pair:sub(1, 1), pair:sub(2, 2)
          local line = vim.api.nvim_get_current_line()
          local cursor = vim.api.nvim_win_get_cursor(0)
          local next = line:sub(cursor[2] + 1, cursor[2] + 1)
          local before = line:sub(1, cursor[2])
          if opts.markdown and o == "`" and vim.bo.filetype == "markdown" and before:match("^%s*``") then
            return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
          end
          if opts.skip_next and next ~= "" and next:match(opts.skip_next) then
            return o
          end
          if opts.skip_ts and #opts.skip_ts > 0 then
            local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
            for _, capture in ipairs(ok and captures or {}) do
              if vim.tbl_contains(opts.skip_ts, capture.capture) then
                return o
              end
            end
          end
          if opts.skip_unbalanced and next == c and c ~= o then
            local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
            local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
            if count_close > count_open then
              return o
            end
          end
          return open(pair, neigh_pattern)
        end
      end

      -- mini.pairs toggle
      Snacks.toggle({
        name = "Mini Pairs",
        get = function() return not vim.g.minipairs_disable end,
        set = function(state) vim.g.minipairs_disable = not state end,
      }):map("<leader>up")
    '';
  };
}
