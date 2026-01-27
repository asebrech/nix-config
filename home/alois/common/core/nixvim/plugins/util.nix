# LazyVim plugins/util.nix - Utility plugins
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./opencode.nix
  ];

  config = {
    # Enable opencode by default
    nixvim-config.plugins.opencode.enable = lib.mkDefault false;

    programs.nixvim = {
      plugins = {
        # Plenary - Lua utilities (dependency for many plugins)
        # Loaded via extraPlugins

        # Web devicons - Icons
        web-devicons = {
          enable = true;
        };
      };

      extraPlugins = with pkgs.vimPlugins; [
        # Core utilities
        plenary-nvim
        nui-nvim

        # Additional utilities
        vim-startuptime

        # Zellij integration
        zellij-nav-nvim
      ];

      # Zellij navigation and terminal keymaps
      extraConfigLua = ''
        -- Zellij navigation setup
        require("zellij-nav").setup()

        -- Better escape for terminal mode
        vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
      '';
    };
  };
}
