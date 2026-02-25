# formatting
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # conform.nvim formats on save and provides a manual format command
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
              "prettier"
              "markdownlint-cli2"
              "markdown-toc"
            ];
            "markdown.mdx" = [
              "prettier"
              "markdownlint-cli2"
              "markdown-toc"
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
            go = [
              "goimports"
              "gofumpt"
            ];
            "_" = [ "trim_whitespace" ]; # fallback for unconfigured filetypes
          };
          formatters = {
            shfmt = {
              prepend_args = [
                "-i"
                "2"
              ];
            };
            "markdown-toc" = {
              condition.__raw = ''
                function(self, ctx)
                  for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                    if line:find("<!%-%- toc %-%->") then return true end
                  end
                end
              '';
            };
            "markdownlint-cli2" = {
              condition.__raw = ''
                function(self, ctx)
                  local diag = vim.tbl_filter(function(d) return d.source == "markdownlint" end, vim.diagnostic.get(ctx.buf))
                  return #diag > 0
                end
              '';
            };
          };
          format_on_save = {
            __raw = ''
              function(bufnr)
                -- Disable when vim.g.autoformat or vim.b.autoformat is explicitly false
                if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
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
        mode = [
          "n"
          "x"
        ];
        key = "<leader>cF";
        action.__raw = ''
          function()
            require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
          end
        '';
        options.desc = "Format Injected Langs";
      }
    ];

    extraConfigLua = ''
      -- toggle options
      Snacks.toggle({
        name = "Auto Format (Buffer)",
        get = function() return vim.b.autoformat ~= false end,
        set = function(state) vim.b.autoformat = state end,
      }):map("<leader>uf")
      Snacks.toggle({
        name = "Auto Format (Global)",
        get = function() return vim.g.autoformat ~= false end,
        set = function(state) vim.g.autoformat = state end,
      }):map("<leader>uF")
    '';
  };
}
