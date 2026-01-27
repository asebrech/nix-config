# TypeScript/JavaScript language support
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # LSP
      lsp.servers = {
        ts_ls = {
          enable = true;
          settings = {
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayVariableTypeHints = true;
              };
            };
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayVariableTypeHints = true;
              };
            };
          };
        };

        eslint = {
          enable = true;
          settings = {
            workingDirectories = {
              mode = "auto";
            };
          };
        };
      };

    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>co";
        action.__raw = ''
          function()
            vim.lsp.buf.code_action({
              apply = true,
              context = {
                only = { "source.organizeImports.ts" },
                diagnostics = {},
              },
            })
          end
        '';
        options.desc = "Organize Imports";
      }
      {
        mode = "n";
        key = "<leader>cR";
        action.__raw = ''
          function()
            vim.lsp.buf.code_action({
              apply = true,
              context = {
                only = { "source.removeUnused.ts" },
                diagnostics = {},
              },
            })
          end
        '';
        options.desc = "Remove Unused Imports";
      }
    ];
  };
}
