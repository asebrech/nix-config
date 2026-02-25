# treesitter
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      # treesitter provides syntax highlighting, indentation, and text objects
      treesitter = {
        enable = true;

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
        };

        folding = true;

        nixvimInjections = true;
      };

      # treesitter-textobjects adds move/select motions for functions, classes, params
      treesitter-textobjects = {
        enable = true;
        settings = {
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
        };
      };

      # treesitter-context pins the current scope at the top of the window
      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 3;
          mode = "cursor";
          separator = null;
        };
      };

      # ts-autotag auto closes and renames HTML tags
      ts-autotag = {
        enable = true;
      };

      # ts-context-commentstring makes comments context-aware (e.g. JSX)
      ts-context-commentstring = {
        enable = true;
        settings = {
          enable_autocmd = false;
        };
      };

      # rainbow-delimiters colors nested brackets for readability
      rainbow-delimiters = {
        enable = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ut";
        action = "<cmd>TSContextToggle<cr>";
        options.desc = "Toggle Treesitter Context";
      }
    ];
  };
}
