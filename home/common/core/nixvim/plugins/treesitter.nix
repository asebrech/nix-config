# LazyVim plugins/treesitter.nix - Treesitter configuration
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      # Treesitter
      treesitter = {
        enable = true;

        # Use pre-compiled grammars from nixpkgs (no C compiler needed)
        nixGrammars = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;

        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };

          indent = {
            enable = true;
          };

          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              scope_incremental = false;
              node_decremental = "<bs>";
            };
          };
        };

        folding = true;

        nixvimInjections = true;
      };

      # Treesitter textobjects
      treesitter-textobjects = {
        enable = true;
        settings = {
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@class.outer";
              "ic" = "@class.inner";
              "aa" = "@parameter.outer";
              "ia" = "@parameter.inner";
            };
          };
          move = {
            enable = true;
            set_jumps = true;
            goto_next_start = {
              "]f" = "@function.outer";
              "]c" = "@class.outer";
              "]a" = "@parameter.inner";
            };
            goto_next_end = {
              "]F" = "@function.outer";
              "]C" = "@class.outer";
              "]A" = "@parameter.inner";
            };
            goto_previous_start = {
              "[f" = "@function.outer";
              "[c" = "@class.outer";
              "[a" = "@parameter.inner";
            };
            goto_previous_end = {
              "[F" = "@function.outer";
              "[C" = "@class.outer";
              "[A" = "@parameter.inner";
            };
          };
          swap = {
            enable = true;
            swap_next = {
              "<leader>a" = "@parameter.inner";
            };
            swap_previous = {
              "<leader>A" = "@parameter.inner";
            };
          };
        };
      };

      # Treesitter context - Shows context at the top
      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 3;
          mode = "cursor";
          separator = null;
        };
      };

      # ts-autotag - Auto close and rename HTML tags
      ts-autotag = {
        enable = true;
      };

      # ts-context-commentstring - Context aware commenting
      ts-context-commentstring = {
        enable = true;
        settings = {
          enable_autocmd = false;
        };
      };

      # Illuminate - Highlight word under cursor
      illuminate = {
        enable = true;
        settings = {
          under_cursor = false;
          delay = 200;
          large_file_overrides = {
            providers = [ "lsp" ];
          };
          filetypes_denylist = [
            "dirbuf"
            "dirvish"
            "fugitive"
            "neo-tree"
            "TelescopePrompt"
          ];
        };
      };

      # Rainbow delimiters
      rainbow-delimiters = {
        enable = true;
      };
    };

    keymaps = [
      # Toggle treesitter context
      {
        mode = "n";
        key = "<leader>ut";
        action = "<cmd>TSContextToggle<cr>";
        options.desc = "Toggle Treesitter Context";
      }
    ];
  };
}
