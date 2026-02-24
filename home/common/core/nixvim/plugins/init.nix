# Snacks.nvim - Core utility plugin setup
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      # Snacks.nvim - Collection of small QoL plugins
      snacks = {
        enable = true;
        settings = {
          bigfile.enabled = true;
          notifier = {
            enabled = true;
            timeout = 3000;
          };
          quickfile.enabled = true;
          words.enabled = true;
          statuscolumn.enabled = true;
          toggle.map = null; # We use our own keymaps
          scroll = {
            enabled = true;
            animate = {
              duration = {
                step = 15;
                total = 250;
              };
              easing = "linear";
            };
          };
          indent = {
            enabled = true;
            indent = {
              char = "|";
            };
            scope = {
              char = "|";
            };
          };
          input.enabled = true;
          scope.enabled = true;
          terminal.enabled = true;
          zen.enabled = true;
          picker = {
            enabled = true;
            win.input.keys.i_esc = "<Esc>";
          };
          dashboard = {
            enabled = true;
            preset = {
              keys.__raw = ''
                {
                  { icon = " ", key = "f", desc = "Find File", action = function() Snacks.dashboard.pick("files") end },
                  { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                  { icon = " ", key = "g", desc = "Find Text", action = function() Snacks.dashboard.pick("live_grep") end },
                  { icon = " ", key = "r", desc = "Recent Files", action = function() Snacks.dashboard.pick("oldfiles") end },
                  { icon = " ", key = "c", desc = "Config", action = ":e $MYVIMRC" },
                  { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
                  { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                }
              '';
            };
            sections.__raw = ''
              {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { section = "recent_files", title = "Recent Files", limit = 5, padding = 1 },
              }
            '';
          };
        };
      };
    };

    # Plugin dependencies
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      nui-nvim
    ];

    extraConfigLua = ''
      local Snacks = require("snacks")

      -- Notifier
      vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })

      -- Buffer delete
      vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })

      -- Terminal
      vim.keymap.set("n", "<leader>ft", function() Snacks.terminal() end, { desc = "Terminal (Root Dir)" })
      vim.keymap.set("n", "<leader>fT", function() Snacks.terminal(nil, { cwd = vim.fn.getcwd() }) end, { desc = "Terminal (cwd)" })
      vim.keymap.set({"n","t"}, "<c-/>", function() Snacks.terminal() end, { desc = "Terminal (Root Dir)" })
      vim.keymap.set({"n","t"}, "<c-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })

      -- Git
      vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })
      vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
      vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
      vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
      vim.keymap.set("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
      vim.keymap.set({"n", "x"}, "<leader>gY", function()
        Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
      end, { desc = "Git Browse (copy)" })

      -- Lazygit
      if vim.fn.executable("lazygit") == 1 then
        vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit (Root Dir)" })
        vim.keymap.set("n", "<leader>gG", function() Snacks.lazygit({ cwd = vim.fn.getcwd() }) end, { desc = "Lazygit (cwd)" })
      end

      -- Words navigation
      vim.keymap.set("n", "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
      vim.keymap.set("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

      -- Rename file
      vim.keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })

      -- Toggles
      vim.keymap.set("n", "<leader>uh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "Toggle Inlay Hints" })
      vim.keymap.set("n", "<leader>uz", function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
      vim.keymap.set("n", "<leader>uZ", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
      vim.keymap.set("n", "<leader>wm", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
    '';
  };
}
