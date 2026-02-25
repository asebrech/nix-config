# keymaps
{ ... }:
{
  programs.nixvim = {
    keymaps = [
      # better up/down
      {
        mode = [
          "n"
          "x"
        ];
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          desc = "Down";
          expr = true;
          silent = true;
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<Down>";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          desc = "Down";
          expr = true;
          silent = true;
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          desc = "Up";
          expr = true;
          silent = true;
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<Up>";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          desc = "Up";
          expr = true;
          silent = true;
        };
      }

      # move to window using <ctrl> arrow keys
      {
        mode = "n";
        key = "<C-Left>";
        action = "<C-w>h";
        options = {
          desc = "Go to Left Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<C-w>j";
        options = {
          desc = "Go to Lower Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<C-Up>";
        action = "<C-w>k";
        options = {
          desc = "Go to Upper Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<C-w>l";
        options = {
          desc = "Go to Right Window";
          remap = true;
        };
      }

      # resize window using <alt> arrow keys
      {
        mode = "n";
        key = "<A-Up>";
        action = "<cmd>resize +2<cr>";
        options.desc = "Increase Window Height";
      }
      {
        mode = "n";
        key = "<A-Down>";
        action = "<cmd>resize -2<cr>";
        options.desc = "Decrease Window Height";
      }
      {
        mode = "n";
        key = "<A-Left>";
        action = "<cmd>vertical resize -2<cr>";
        options.desc = "Decrease Window Width";
      }
      {
        mode = "n";
        key = "<A-Right>";
        action = "<cmd>vertical resize +2<cr>";
        options.desc = "Increase Window Width";
      }

      # move lines
      {
        mode = "n";
        key = "<A-j>";
        action.__raw = ''
          function()
            vim.cmd("execute 'move .+" .. vim.v.count1 .. "'")
            vim.cmd("normal! ==")
          end
        '';
        options = {
          desc = "Move Down";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<A-k>";
        action.__raw = ''
          function()
            vim.cmd("execute 'move .-" .. (vim.v.count1 + 1) .. "'")
            vim.cmd("normal! ==")
          end
        '';
        options = {
          desc = "Move Up";
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<A-j>";
        action = "<esc><cmd>m .+1<cr>==gi";
        options.desc = "Move Down";
      }
      {
        mode = "i";
        key = "<A-k>";
        action = "<esc><cmd>m .-2<cr>==gi";
        options.desc = "Move Up";
      }
      {
        mode = "v";
        key = "<A-j>";
        action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
        options.desc = "Move Down";
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
        options.desc = "Move Up";
      }
      {
        mode = "i";
        key = "<A-Down>";
        action = "<esc><cmd>m .+1<cr>==gi";
        options.desc = "Move Down";
      }
      {
        mode = "i";
        key = "<A-Up>";
        action = "<esc><cmd>m .-2<cr>==gi";
        options.desc = "Move Up";
      }
      {
        mode = "x";
        key = "<A-Down>";
        action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
        options.desc = "Move Down";
      }
      {
        mode = "x";
        key = "<A-Up>";
        action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
        options.desc = "Move Up";
      }

      # buffers
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>e #<cr>";
        options.desc = "Switch to Other Buffer";
      }
      {
        mode = "n";
        key = "<leader>`";
        action = "<cmd>e #<cr>";
        options.desc = "Switch to Other Buffer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>lua Snacks.bufdelete()<cr>";
        options.desc = "Delete Buffer";
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>:bd<cr>";
        options.desc = "Delete Buffer and Window";
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>lua Snacks.bufdelete.other()<cr>";
        options.desc = "Delete Other Buffers";
      }

      # clear search with <esc>
      {
        mode = [
          "i"
          "n"
          "s"
        ];
        key = "<esc>";
        action.__raw = ''
          function()
            vim.cmd("noh")
            if vim.snippet then
              vim.snippet.stop()
            end
            return "<esc>"
          end
        '';
        options = {
          desc = "Escape and Clear hlsearch";
          expr = true;
        };
      }

      # clear search, diff update and redraw
      {
        mode = "n";
        key = "<leader>ur";
        action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
        options.desc = "Redraw / Clear hlsearch / Diff Update";
      }

      # saner behavior of n and N
      # https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
      {
        mode = "n";
        key = "n";
        action = "'Nn'[v:searchforward].'zv'";
        options = {
          expr = true;
          desc = "Next Search Result";
        };
      }
      {
        mode = "x";
        key = "n";
        action = "'Nn'[v:searchforward]";
        options = {
          expr = true;
          desc = "Next Search Result";
        };
      }
      {
        mode = "o";
        key = "n";
        action = "'Nn'[v:searchforward]";
        options = {
          expr = true;
          desc = "Next Search Result";
        };
      }
      {
        mode = "n";
        key = "N";
        action = "'nN'[v:searchforward].'zv'";
        options = {
          expr = true;
          desc = "Prev Search Result";
        };
      }
      {
        mode = "x";
        key = "N";
        action = "'nN'[v:searchforward]";
        options = {
          expr = true;
          desc = "Prev Search Result";
        };
      }
      {
        mode = "o";
        key = "N";
        action = "'nN'[v:searchforward]";
        options = {
          expr = true;
          desc = "Prev Search Result";
        };
      }

      # add undo break-points
      {
        mode = "i";
        key = ",";
        action = ",<c-g>u";
      }
      {
        mode = "i";
        key = ".";
        action = ".<c-g>u";
      }
      {
        mode = "i";
        key = ";";
        action = ";<c-g>u";
      }

      # save file
      {
        mode = [
          "i"
          "x"
          "n"
          "s"
        ];
        key = "<C-s>";
        action = "<cmd>w<cr><esc>";
        options.desc = "Save File";
      }

      # keywordprg
      {
        mode = "n";
        key = "<leader>K";
        action = "<cmd>norm! K<cr>";
        options.desc = "Keywordprg";
      }

      # better indenting
      {
        mode = "x";
        key = "<";
        action = "<gv";
      }
      {
        mode = "x";
        key = ">";
        action = ">gv";
      }

      # commenting
      {
        mode = "n";
        key = "gco";
        action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
        options.desc = "Add Comment Below";
      }
      {
        mode = "n";
        key = "gcO";
        action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
        options.desc = "Add Comment Above";
      }

      # new file
      {
        mode = "n";
        key = "<leader>fn";
        action = "<cmd>enew<cr>";
        options.desc = "New File";
      }

      # location and quickfix list
      {
        mode = "n";
        key = "<leader>xl";
        action.__raw = ''
          function()
            local ok, err = pcall(
              vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen
            )
            if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
          end
        '';
        options.desc = "Location List";
      }
      {
        mode = "n";
        key = "<leader>xq";
        action.__raw = ''
          function()
            local ok, err = pcall(
              vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen
            )
            if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
          end
        '';
        options.desc = "Quickfix List";
      }
      {
        mode = "n";
        key = "[q";
        action = "<cmd>cprev<cr>";
        options.desc = "Previous Quickfix";
      }
      {
        mode = "n";
        key = "]q";
        action = "<cmd>cnext<cr>";
        options.desc = "Next Quickfix";
      }

      # diagnostic
      {
        mode = "n";
        key = "]d";
        action.__raw = ''
          function()
            vim.diagnostic.jump({ count = vim.v.count1, float = true })
          end
        '';
        options.desc = "Next Diagnostic";
      }
      {
        mode = "n";
        key = "[d";
        action.__raw = ''
          function()
            vim.diagnostic.jump({ count = -vim.v.count1, float = true })
          end
        '';
        options.desc = "Prev Diagnostic";
      }
      {
        mode = "n";
        key = "]e";
        action.__raw = ''
          function()
            vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.ERROR, float = true })
          end
        '';
        options.desc = "Next Error";
      }
      {
        mode = "n";
        key = "[e";
        action.__raw = ''
          function()
            vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.ERROR, float = true })
          end
        '';
        options.desc = "Prev Error";
      }
      {
        mode = "n";
        key = "]w";
        action.__raw = ''
          function()
            vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.WARN, float = true })
          end
        '';
        options.desc = "Next Warning";
      }
      {
        mode = "n";
        key = "[w";
        action.__raw = ''
          function()
            vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.WARN, float = true })
          end
        '';
        options.desc = "Prev Warning";
      }

      # toggle options (via Snacks.toggle in init.nix)

      # quit
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>qa<cr>";
        options.desc = "Quit All";
      }

      # highlights under cursor
      {
        mode = "n";
        key = "<leader>ui";
        action = "<cmd>lua vim.show_pos()<cr>";
        options.desc = "Inspect Pos";
      }
      {
        mode = "n";
        key = "<leader>uI";
        action.__raw = ''
          function()
            vim.treesitter.inspect_tree()
            vim.api.nvim_input("I")
          end
        '';
        options.desc = "Inspect Tree";
      }

      # windows
      {
        mode = "n";
        key = "<leader>?";
        action.__raw = ''function() require("which-key").show({ global = false }) end'';
        options.desc = "Buffer Keymaps (which-key)";
      }
      {
        mode = "n";
        key = "<c-w><space>";
        action.__raw = ''function() require("which-key").show({ keys = "<c-w>", loop = true }) end'';
        options.desc = "Window Hydra Mode (which-key)";
      }
      {
        mode = "n";
        key = "<leader>-";
        action = "<C-W>s";
        options = {
          desc = "Split Window Below";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>|";
        action = "<C-W>v";
        options = {
          desc = "Split Window Right";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wd";
        action = "<C-W>c";
        options = {
          desc = "Delete Window";
          remap = true;
        };
      }

      # tabs
      {
        mode = "n";
        key = "<leader><tab>l";
        action = "<cmd>tablast<cr>";
        options.desc = "Last Tab";
      }
      {
        mode = "n";
        key = "<leader><tab>o";
        action = "<cmd>tabonly<cr>";
        options.desc = "Close Other Tabs";
      }
      {
        mode = "n";
        key = "<leader><tab>f";
        action = "<cmd>tabfirst<cr>";
        options.desc = "First Tab";
      }
      {
        mode = "n";
        key = "<leader><tab><tab>";
        action = "<cmd>tabnew<cr>";
        options.desc = "New Tab";
      }
      {
        mode = "n";
        key = "<leader><tab>]";
        action = "<cmd>tabnext<cr>";
        options.desc = "Next Tab";
      }
      {
        mode = "n";
        key = "<leader><tab>d";
        action = "<cmd>tabclose<cr>";
        options.desc = "Close Tab";
      }
      {
        mode = "n";
        key = "<leader><tab>[";
        action = "<cmd>tabprevious<cr>";
        options.desc = "Previous Tab";
      }
    ];
  };
}
