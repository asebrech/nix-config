# Rust language support
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # Rustaceanvim - Better Rust support
      rustaceanvim = {
        enable = true;
        settings = {
          server = {
            on_attach.__raw = ''
              function(client, bufnr)
                -- Rust-specific keymaps
                vim.keymap.set("n", "<leader>cR", function()
                  vim.cmd.RustLsp("codeAction")
                end, { desc = "Code Action", buffer = bufnr })
                vim.keymap.set("n", "<leader>dr", function()
                  vim.cmd.RustLsp("debuggables")
                end, { desc = "Rust Debuggables", buffer = bufnr })
              end
            '';
            default_settings = {
              rust-analyzer = {
                cargo = {
                  allFeatures = true;
                  loadOutDirsFromCheck = true;
                  buildScripts.enable = true;
                };
                checkOnSave = true;
                procMacro = {
                  enable = true;
                  ignored = {
                    leptos_macro = [
                      "component"
                      "server"
                    ];
                  };
                };
              };
            };
          };
        };
      };

      # Crates.nvim - Cargo.toml management
      crates = {
        enable = true;
        settings = {
          # Uses in-process language server instead of deprecated nvim-cmp source
          lsp = {
            enabled = true;
            actions = true;
            completion = true;
            hover = true;
          };
        };
      };

    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ct";
        action.__raw = ''
          function()
            require("crates").toggle()
          end
        '';
        options.desc = "Toggle Crates";
      }
    ];
  };
}
