# rust
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # rustaceanvim provides enhanced rust-analyzer integration and debuggables
      rustaceanvim = {
        enable = true;
        settings = {
          server = {
            on_attach.__raw = ''
              function(client, bufnr)
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
                diagnostics = {
                  enable = true;
                };
                procMacro = {
                  enable = true;
                };
                files = {
                  exclude = [
                    ".direnv"
                    ".git"
                    ".jj"
                    ".github"
                    ".gitlab"
                    "bin"
                    "node_modules"
                    "target"
                    "venv"
                    ".venv"
                  ];
                  watcher = "client";
                };
              };
            };
          };
        };
      };

      # crates.nvim manages Cargo.toml dependencies with inline version info
      crates = {
        enable = true;
        settings = {
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
