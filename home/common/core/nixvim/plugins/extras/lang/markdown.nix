# Markdown language support
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      # LSP
      lsp.servers = {
        marksman.enable = true;
      };

      # Linting
      lint.lintersByFt = {
        markdown = [ "markdownlint" ];
      };

      # Render markdown
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
      {
        mode = "n";
        key = "<leader>um";
        action.__raw = ''
          function()
            require("render-markdown").toggle()
          end
        '';
        options.desc = "Toggle Render Markdown";
      }
    ];
  };
}
