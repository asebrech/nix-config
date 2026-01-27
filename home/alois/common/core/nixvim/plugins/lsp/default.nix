# LazyVim plugins/lsp/default.nix - LSP configuration
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # LSP Config
      lsp = {
        enable = true;

        # Keymaps applied when LSP attaches to a buffer
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
              action = "code_action";
              desc = "Code Action";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
          };
        };

        # Inlay hints (Neovim 0.10+)
        inlayHints = true;

        # Servers
        servers = {
          # Lua
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

          # Nix
          nil_ls = {
            enable = true;
            settings = {
              formatting = {
                command = [ "nixfmt" ];
              };
            };
          };

          # JSON
          jsonls = {
            enable = true;
          };

          # YAML
          yamlls = {
            enable = true;
          };

          # Bash
          bashls = {
            enable = true;
          };

          # Markdown
          marksman = {
            enable = true;
          };
        };
      };

      # Fidget.nvim - LSP progress
      fidget = {
        enable = true;
        settings = {
          notification = {
            window = {
              winblend = 0;
            };
          };
        };
      };

      # lsp_signature.nvim - Signature help
      lsp-signature = {
        enable = true;
        settings = {
          hint_enable = false;
          handler_opts = {
            border = "rounded";
          };
        };
      };

      # Schemastore for JSON/YAML schemas
      schemastore = {
        enable = true;
        json.enable = true;
        yaml.enable = true;
      };
    };

    # Additional LSP-related keymaps
    keymaps = [
      {
        mode = "n";
        key = "<leader>cl";
        action = "<cmd>LspInfo<cr>";
        options.desc = "Lsp Info";
      }
      {
        mode = "n";
        key = "<leader>uh";
        action.__raw = ''
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end
        '';
        options.desc = "Toggle Inlay Hints";
      }
      {
        mode = "n";
        key = "<leader>cc";
        action.__raw = "vim.lsp.codelens.run";
        options.desc = "Run Codelens";
      }
      {
        mode = "n";
        key = "<leader>cC";
        action.__raw = "vim.lsp.codelens.refresh";
        options.desc = "Refresh & Display Codelens";
      }
    ];

    extraConfigLua = ''
      -- Diagnostic configuration
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
