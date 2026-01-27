# GitHub Copilot support
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # Copilot.lua - Native Copilot integration
      copilot-lua = {
        enable = true;
        settings = {
          suggestion = {
            enabled = false; # Using blink.cmp instead
          };
          panel = {
            enabled = false;
          };
          filetypes = {
            markdown = true;
            help = true;
          };
        };
      };

      # Blink.cmp source for Copilot (already configured in coding.nix)
      # The blink-cmp source is enabled when copilot-lua is active
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>at";
        action = "<cmd>Copilot toggle<cr>";
        options.desc = "Toggle Copilot";
      }
    ];
  };
}
