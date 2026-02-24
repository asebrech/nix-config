# Oil.nvim - File explorer that lets you edit filesystem like a buffer
{ ... }:
{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        default_file_explorer = false;
        columns = [
          "icon"
        ];
        keymaps = {
          "g?" = {
            __raw = ''"actions.show_help"'';
          };
          "<CR>" = {
            __raw = ''"actions.select"'';
          };
          "<C-s>" = {
            __raw = ''"actions.select_vsplit"'';
          };
          "<C-x>" = {
            __raw = ''"actions.select_split"'';
          };
          "<C-t>" = {
            __raw = ''"actions.select_tab"'';
          };
          "<C-p>" = {
            __raw = ''"actions.preview"'';
          };
          "<C-c>" = {
            __raw = ''"actions.close"'';
          };
          "<C-r>" = {
            __raw = ''"actions.refresh"'';
          };
          "-" = {
            __raw = ''"actions.parent"'';
          };
          "_" = {
            __raw = ''"actions.open_cwd"'';
          };
          "`" = {
            __raw = ''"actions.cd"'';
          };
          "~" = {
            __raw = ''
              {
                __raw = "actions.cd",
                opts = { scope = "tab" },
                mode = "n"
              }
            '';
          };
          "gs" = {
            __raw = ''"actions.change_sort"'';
          };
          "gx" = {
            __raw = ''"actions.open_external"'';
          };
          "g." = {
            __raw = ''"actions.toggle_hidden"'';
          };
          "g\\" = {
            __raw = ''"actions.toggle_trash"'';
          };
        };
        use_default_keymaps = false;
        view_options = {
          show_hidden = false;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>fo";
        action = "<cmd>Oil<cr>";
        options.desc = "Oil File Browser";
      }
    ];
  };
}
