# Python language support
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # LSP
      lsp.servers = {
        pyright = {
          enable = true;
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true;
                diagnosticMode = "openFilesOnly";
                useLibraryCodeForTypes = true;
              };
            };
          };
        };
        ruff = {
          enable = true;
          settings = {
            cmd_env = {
              RUFF_TRACE = "messages";
            };
            init_options = {
              settings = {
                logLevel = "error";
              };
            };
          };
        };
      };

      # Linting
      lint.lintersByFt = {
        python = [ "ruff" ];
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
                only = { "source.organizeImports" },
                diagnostics = {},
              },
            })
          end
        '';
        options.desc = "Organize Imports";
      }
    ];
  };
}
