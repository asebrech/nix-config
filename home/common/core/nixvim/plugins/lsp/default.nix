# lsp
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # nvim-lspconfig wires up language servers with keymaps and diagnostics
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>cd" = {
              action = "open_float";
              desc = "Line Diagnostics";
            };
          };
          lspBuf = {
            "gd" = {
              action = "definition";
              desc = "Goto Definition";
            };
            "gr" = {
              action = "references";
              desc = "References";
            };
            "gI" = {
              action = "implementation";
              desc = "Goto Implementation";
            };
            "gy" = {
              action = "type_definition";
              desc = "Goto Type Definition";
            };
            "gD" = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            "K" = {
              action = "hover";
              desc = "Hover";
            };
            "gK" = {
              action = "signature_help";
              desc = "Signature Help";
            };
            "<c-k>" = {
              mode = "i";
              action = "signature_help";
              desc = "Signature Help";
            };
            "<leader>ca" = {
              mode = [
                "n"
                "x"
              ];
              action = "code_action";
              desc = "Code Action";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
          };
        };

        inlayHints = true;

        servers = {
          lua_ls = {
            enable = true;
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false;
                };
                codeLens = {
                  enable = true;
                };
                completion = {
                  callSnippet = "Replace";
                };
                doc = {
                  privateName = [ "^_" ];
                };
                hint = {
                  enable = true;
                  setType = false;
                  paramType = true;
                  paramName = "Disable";
                  semicolon = "Disable";
                  arrayIndex = "Disable";
                };
              };
            };
          };

          jsonls = {
            enable = true;
          };

          yamlls = {
            enable = true;
          };

          bashls = {
            enable = true;
          };

          marksman = {
            enable = true;
          };
        };
      };

      # lsp-signature shows function signatures in insert mode
      lsp-signature = {
        enable = true;
        settings = {
          hint_enable = false;
          handler_opts = {
            border = "rounded";
          };
        };
      };

      # schemastore provides JSON/YAML schemas for jsonls and yamlls
      schemastore = {
        enable = true;
        json.enable = true;
        yaml.enable = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>cl";
        action = "<cmd>lua Snacks.picker.lsp_config()<cr>";
        options.desc = "Lsp Info";
      }
      {
        mode = "n";
        key = "<leader>cA";
        action.__raw = ''
          function()
            vim.lsp.buf.code_action({
              apply = true,
              context = {
                only = { "source" },
                diagnostics = {},
              },
            })
          end
        '';
        options.desc = "Source Action";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>cc";
        action = "<cmd>lua vim.lsp.codelens.run()<cr>";
        options.desc = "Run Codelens";
      }
      {
        mode = "n";
        key = "<leader>cC";
        action = "<cmd>lua vim.lsp.codelens.refresh()<cr>";
        options.desc = "Refresh & Display Codelens";
      }
      {
        mode = "n";
        key = "<a-n>";
        action.__raw = "function() Snacks.words.jump(vim.v.count1, true) end";
        options.desc = "Next Reference";
      }
      {
        mode = "n";
        key = "<a-p>";
        action.__raw = "function() Snacks.words.jump(-vim.v.count1, true) end";
        options.desc = "Prev Reference";
      }
    ];

    extraConfigLua = ''
      -- diagnostic
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })
    '';
  };
}
