# typescript
{ ... }:
{
  programs.nixvim = {
    plugins = {
      lsp.servers = {
        ts_ls = {
          enable = false; # disabled in favour of vtsls
        };

        vtsls = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "javascript.jsx"
            "typescript"
            "typescriptreact"
            "typescript.tsx"
          ];
          settings = {
            complete_function_calls = true;
            vtsls = {
              enableMoveToFileCodeAction = true;
              autoUseWorkspaceTsdk = true;
              experimental = {
                maxInlayHintLength = 30;
                completion = {
                  enableServerSideFuzzyMatch = true;
                };
              };
            };
            typescript = {
              updateImportsOnFileMove = {
                enabled = "always";
              };
              suggest = {
                completeFunctionCalls = true;
              };
              inlayHints = {
                enumMemberValues = {
                  enabled = true;
                };
                functionLikeReturnTypes = {
                  enabled = true;
                };
                parameterNames = {
                  enabled = "literals";
                };
                parameterTypes = {
                  enabled = true;
                };
                propertyDeclarationTypes = {
                  enabled = true;
                };
                variableTypes = {
                  enabled = false;
                };
              };
            };
            javascript = {
              updateImportsOnFileMove = {
                enabled = "always";
              };
              suggest = {
                completeFunctionCalls = true;
              };
              inlayHints = {
                enumMemberValues = {
                  enabled = true;
                };
                functionLikeReturnTypes = {
                  enabled = true;
                };
                parameterNames = {
                  enabled = "literals";
                };
                parameterTypes = {
                  enabled = true;
                };
                propertyDeclarationTypes = {
                  enabled = true;
                };
                variableTypes = {
                  enabled = false;
                };
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
        key = "gD";
        action.__raw = ''
          function()
            require("vtsls").commands.goto_source_definition(0)
          end
        '';
        options.desc = "Goto Source Definition";
      }
      {
        mode = "n";
        key = "gR";
        action.__raw = ''
          function()
            require("vtsls").commands.file_references(0)
          end
        '';
        options.desc = "File References";
      }
      {
        mode = "n";
        key = "<leader>co";
        action.__raw = ''
          function()
            vim.lsp.buf.code_action({
              apply = true,
              context = {
                only = { "source.organizeImports" },
                diagnostics = {},
              },
            })
          end
        '';
        options.desc = "Organize Imports";
      }
      {
        mode = "n";
        key = "<leader>cM";
        action.__raw = ''
          function()
            vim.lsp.buf.code_action({
              apply = true,
              context = {
                only = { "source.addMissingImports.ts" },
                diagnostics = {},
              },
            })
          end
        '';
        options.desc = "Add Missing Imports";
      }
      {
        mode = "n";
        key = "<leader>cu";
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
      {
        mode = "n";
        key = "<leader>cD";
        action.__raw = ''
          function()
            vim.lsp.buf.code_action({
              apply = true,
              context = {
                only = { "source.fixAll.ts" },
                diagnostics = {},
              },
            })
          end
        '';
        options.desc = "Fix All Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>cV";
        action.__raw = ''
          function()
            vim.lsp.buf.execute_command({ command = "typescript.selectTypeScriptVersion" })
          end
        '';
        options.desc = "Select TS Workspace Version";
      }
    ];
  };
}
