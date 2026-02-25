# markdown
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      lsp.servers = {
        marksman.enable = true;
      };

      lint.lintersByFt = {
        markdown = [ "markdownlint-cli2" ];
      };

      # render-markdown renders markdown in-buffer with virtual text
      render-markdown = {
        enable = true;
        settings = {
          code = {
            sign = false;
            width = "block";
            right_pad = 1;
          };
          heading = {
            sign = false;
            icons = [ ];
          };
          checkbox = {
            enabled = false;
          };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      markdown-preview-nvim
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>cp";
        action = "<cmd>MarkdownPreviewToggle<cr>";
        options.desc = "Markdown Preview";
      }
    ];

    extraConfigLua = ''
      -- mdx filetype
      vim.filetype.add({ extension = { mdx = "markdown.mdx" } })

      -- toggle options
      Snacks.toggle({
        name = "Render Markdown",
        get = require("render-markdown").get,
        set = require("render-markdown").set,
      }):map("<leader>um")
    '';
  };
}
