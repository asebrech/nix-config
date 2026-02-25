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
        zellij-nav-nvim
      ];

      extraConfigLua = ''
        -- zellij navigation
        require("zellij-nav").setup()

        -- better escape for terminal mode
        vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
      '';
    };
  };
}
