# Mini.files - File explorer as a buffer
{ ... }:
{
  programs.nixvim = {
    plugins.mini = {
      enable = true;
      modules = {
        files = {
          options = {
            use_as_default_explorer = false;
          };
          windows = {
            preview = true;
            width_focus = 30;
            width_preview = 30;
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>fm";
        action.__raw = ''
          function()
            require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
          end
        '';
        options.desc = "Open mini.files (Directory of Current File)";
      }
      {
        mode = "n";
        key = "<leader>fM";
        action.__raw = ''
          function()
            require("mini.files").open(vim.uv.cwd(), true)
          end
        '';
        options.desc = "Open mini.files (cwd)";
      }
    ];
  };
}
