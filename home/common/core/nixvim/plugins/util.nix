# util
{ pkgs, ... }:
{
  imports = [
    ./opencode.nix
  ];

  config = {
    programs.nixvim = {
      plugins = {
        web-devicons = {
          enable = true;
        };
      };

      extraPlugins = with pkgs.vimPlugins; [
        plenary-nvim
        nui-nvim
        vim-startuptime
        vim-tmux-navigator
      ];

      extraConfigLua = ''
        -- vim-tmux-navigator: C-Arrow keys to move between nvim splits and tmux panes
        -- Matches the tmux side config which uses C-Left/Right/Up/Down
        vim.g.tmux_navigator_no_mappings = 1
        vim.keymap.set("n", "<C-Left>",  "<cmd>TmuxNavigateLeft<cr>",  { desc = "Navigate left (tmux/nvim)" })
        vim.keymap.set("n", "<C-Down>",  "<cmd>TmuxNavigateDown<cr>",  { desc = "Navigate down (tmux/nvim)" })
        vim.keymap.set("n", "<C-Up>",    "<cmd>TmuxNavigateUp<cr>",    { desc = "Navigate up (tmux/nvim)" })
        vim.keymap.set("n", "<C-Right>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate right (tmux/nvim)" })

        -- better escape for terminal mode
        vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
      '';
    };
  };
}
