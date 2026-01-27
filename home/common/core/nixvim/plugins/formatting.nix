# LazyVim plugins/formatting.nix - Code formatting
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # Conform.nvim - Formatting
      conform-nvim = {
        enable = true;
        settings = {
          default_format_opts = {
            timeout_ms = 3000;
            async = false;
            quiet = false;
            lsp_format = "fallback";
          };
          formatters_by_ft = {
            lua = [ "stylua" ];
            fish = [ "fish_indent" ];
            sh = [ "shfmt" ];
            nix = [ "nixfmt" ];
            python = [ "black" ];
            javascript = [
              "prettierd"
              "prettier"
            ];
            typescript = [
              "prettierd"
              "prettier"
            ];
            javascriptreact = [
              "prettierd"
              "prettier"
            ];
            typescriptreact = [
              "prettierd"
              "prettier"
            ];
            json = [
              "prettierd"
              "prettier"
            ];
            yaml = [
              "prettierd"
              "prettier"
            ];
            markdown = [
              "prettierd"
              "prettier"
            ];
            html = [
              "prettierd"
              "prettier"
            ];
            css = [
              "prettierd"
              "prettier"
            ];
            rust = [ "rustfmt" ];
            go = [ "gofmt" ];
            # Use the "_" filetype to run formatters on filetypes that don't
            # have other formatters configured.
            "_" = [ "trim_whitespace" ];
          };
          formatters = {
            shfmt = {
              prepend_args = [
                "-i"
                "2"
              ];
            };
          };
          format_on_save = {
            __raw = ''
              function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end
                return { timeout_ms = 3000, lsp_format = "fallback" }
              end
            '';
          };
        };
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>cf";
        action.__raw = ''
          function()
            require("conform").format({ async = true })
          end
        '';
        options.desc = "Format";
      }
      {
        mode = "n";
        key = "<leader>cF";
        action.__raw = ''
          function()
            require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
          end
        '';
        options.desc = "Format Injected Langs";
      }
      # Toggle autoformat
      {
        mode = "n";
        key = "<leader>uf";
        action.__raw = ''
          function()
            vim.b.disable_autoformat = not vim.b.disable_autoformat
            if vim.b.disable_autoformat then
              vim.notify("Autoformat disabled for buffer", vim.log.levels.INFO)
            else
              vim.notify("Autoformat enabled for buffer", vim.log.levels.INFO)
            end
          end
        '';
        options.desc = "Toggle Autoformat (Buffer)";
      }
      {
        mode = "n";
        key = "<leader>uF";
        action.__raw = ''
          function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            if vim.g.disable_autoformat then
              vim.notify("Autoformat disabled globally", vim.log.levels.INFO)
            else
              vim.notify("Autoformat enabled globally", vim.log.levels.INFO)
            end
          end
        '';
        options.desc = "Toggle Autoformat (Global)";
      }
    ];
  };
}
