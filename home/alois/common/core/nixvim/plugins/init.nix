# LazyVim plugins/init.nix - Core plugin setup
# Snacks.nvim is the main utility plugin used by LazyVim
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
          dashboard = {
            enabled = true;
            preset = {
              keys.__raw = ''
                {
                  { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
                  { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                  { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
                  { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
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

    # Extra plugins not directly configured by nixvim
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      nui-nvim
    ];

    extraConfigLua = ''
      -- Snacks keymaps
      local Snacks = require("snacks")

      -- Notifier
      vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })

      -- Buffer delete
      vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })

      -- Terminal
      vim.keymap.set("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
      vim.keymap.set("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = vim.fn.getcwd() }) end, { desc = "Terminal (Root Dir)" })
      vim.keymap.set({"n","t"}, "<c-/>", function() Snacks.terminal(nil, { cwd = vim.fn.getcwd() }) end, { desc = "Terminal (Root Dir)" })
      vim.keymap.set({"n","t"}, "<c-_>", function() Snacks.terminal(nil, { cwd = vim.fn.getcwd() }) end, { desc = "which_key_ignore" })

      -- Git
      vim.keymap.set("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
      vim.keymap.set({"n", "x"}, "<leader>gY", function()
        Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
      end, { desc = "Git Browse (copy)" })

      -- Lazygit
      if vim.fn.executable("lazygit") == 1 then
        vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit({ cwd = vim.fn.getcwd() }) end, { desc = "Lazygit (Root Dir)" })
        vim.keymap.set("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
        vim.keymap.set("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
        vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit.log({ cwd = vim.fn.getcwd() }) end, { desc = "Lazygit Log" })
        vim.keymap.set("n", "<leader>gL", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })
      end

      -- Words navigation
      vim.keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
      vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

      -- Rename file
      vim.keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
    '';
  };
}
