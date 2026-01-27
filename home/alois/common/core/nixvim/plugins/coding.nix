# LazyVim plugins/coding.nix - Coding support plugins
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      # Blink.cmp - Fast completion engine
      blink-cmp = {
        enable = true;
        settings = {
          appearance = {
            use_nvim_cmp_as_default = true;
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
            ghost_text.enabled = true;
          };
          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
            ];
          };
          cmdline = {
            enabled = true;
          };
          keymap = {
            preset = "enter";
            "<C-y>" = [ "select_and_accept" ];
          };
        };
      };

      # Snippets - Use native neovim snippets with friendly-snippets
      friendly-snippets.enable = true;

      # Auto pairs
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
          ts_config = {
            lua = [ "string" ];
            javascript = [ "template_string" ];
          };
        };
      };

      # Surround
      nvim-surround = {
        enable = true;
        settings = { };
      };

      # Comment
      comment = {
        enable = true;
        settings = {
          opleader = {
            line = "gc";
            block = "gb";
          };
        };
      };

      # Todo comments
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

      # Mini.ai - Better text objects
      mini = {
        enable = true;
        modules = {
          ai = {
            n_lines = 500;
            custom_textobjects = {
              o = {
                __raw = ''
                  require('mini.ai').gen_spec.treesitter({
                    a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                  }, {})
                '';
              };
              f = {
                __raw = ''
                  require('mini.ai').gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {})
                '';
              };
              c = {
                __raw = ''
                  require('mini.ai').gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {})
                '';
              };
              t = [
                "<([%p%w]-)%f[^<%w][^<>]->.-</%1>"
                "^<.teleport->().teleport()</[^/]->$"
              ];
              d = [ "%f[%d]%d+" ];
            };
          };
          pairs = {
            mappings = {
              "(" = {
                action = "open";
                pair = "()";
                neigh_pattern = "[^\\].";
              };
              "[" = {
                action = "open";
                pair = "[]";
                neigh_pattern = "[^\\].";
              };
              "{" = {
                action = "open";
                pair = "{}";
                neigh_pattern = "[^\\].";
              };
              ")" = {
                action = "close";
                pair = "()";
                neigh_pattern = "[^\\].";
              };
              "]" = {
                action = "close";
                pair = "[]";
                neigh_pattern = "[^\\].";
              };
              "}" = {
                action = "close";
                pair = "{}";
                neigh_pattern = "[^\\].";
              };
              "\"" = {
                action = "closeopen";
                pair = "\"\"";
                neigh_pattern = "[^\\].";
                register = {
                  cr = false;
                };
              };
              "'" = {
                action = "closeopen";
                pair = "''";
                neigh_pattern = "[^%a\\].";
                register = {
                  cr = false;
                };
              };
              "`" = {
                action = "closeopen";
                pair = "``";
                neigh_pattern = "[^\\].";
                register = {
                  cr = false;
                };
              };
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

      # Lazydev - Lua development for neovim config
      lazydev = {
        enable = true;
        settings = {
          library = [
            {
              path = "\${3rd}/luv/library";
              words = [ "vim%.uv" ];
            }
          ];
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-repeat
    ];

    # Keymaps for todo-comments
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
  };
}
