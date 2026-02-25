# snacks.nvim
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      # a collection of small QoL plugins
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
          toggle = { };
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

    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      nui-nvim
    ];

    extraConfigLua = ''
      local Snacks = require("snacks")

      -- notifier
      vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
      vim.keymap.set("n", "<leader>n", function()
        if Snacks.config.picker and Snacks.config.picker.enabled then
          Snacks.picker.notifications()
        else
          Snacks.notifier.show_history()
        end
      end, { desc = "Notification History" })

      -- floating terminal
      vim.keymap.set("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = Snacks.git.get_root() }) end, { desc = "Terminal (Root Dir)" })
      vim.keymap.set("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
      vim.keymap.set({"n","t"}, "<c-/>", function() Snacks.terminal(nil, { cwd = Snacks.git.get_root() }) end, { desc = "Terminal (Root Dir)" })
      vim.keymap.set({"n","t"}, "<c-_>", function() Snacks.terminal(nil, { cwd = Snacks.git.get_root() }) end, { desc = "which_key_ignore" })

      -- git
      vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })
      vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
      vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
      vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log({ cwd = Snacks.git.get_root() }) end, { desc = "Git Log" })
      vim.keymap.set({"n", "x"}, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
      vim.keymap.set({"n", "x"}, "<leader>gY", function()
        Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
      end, { desc = "Git Browse (copy)" })

      -- lazygit
      if vim.fn.executable("lazygit") == 1 then
        vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit({ cwd = Snacks.git.get_root() }) end, { desc = "Lazygit (Root Dir)" })
        vim.keymap.set("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
      end

      -- words navigation
      vim.keymap.set("n", "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
      vim.keymap.set("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

      -- rename file
      vim.keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })

      -- toggle options
      Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
      Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
      Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
      Snacks.toggle.line_number():map("<leader>ul")
      Snacks.toggle.diagnostics():map("<leader>ud")
      Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
      Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
      Snacks.toggle.treesitter():map("<leader>uT")
      Snacks.toggle.inlay_hints():map("<leader>uh")
      Snacks.toggle.indent():map("<leader>ug")
      Snacks.toggle.dim():map("<leader>uD")
      Snacks.toggle.animate():map("<leader>ua")
      Snacks.toggle.scroll():map("<leader>uS")
      Snacks.toggle.zoom():map("<leader>uZ"):map("<leader>wm")
      Snacks.toggle.zen():map("<leader>uz")
      Snacks.toggle.profiler():map("<leader>dpp")
      Snacks.toggle.profiler_highlights():map("<leader>dph")

      -- lua
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lua",
        callback = function(ev)
          vim.keymap.set({"n", "x"}, "<localleader>r", function() Snacks.debug.run() end, { buffer = ev.buf, desc = "Run Lua" })
        end,
      })

      -- opencode.nvim snacks picker integration
      Snacks.config.picker = vim.tbl_deep_extend("force", Snacks.config.picker or {}, {
        actions = {
          opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
        },
        win = {
          input = {
            keys = {
              ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
            },
          },
        },
      })
    '';
  };
}
