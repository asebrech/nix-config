# copilot
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # copilot-lua integrates GitHub Copilot; suggestions handled via blink.cmp
      copilot-lua = {
        enable = true;
        settings = {
          suggestion = {
            enabled = false; # blink.cmp handles suggestions
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
