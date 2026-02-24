# LazyVim-style keymaps for nixvim
{ ... }:
{
  programs.nixvim = {
    keymaps = [
      # Better up/down
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

      # Move to window using <ctrl> hjkl keys
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          desc = "Go to Left Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          desc = "Go to Lower Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          desc = "Go to Upper Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          desc = "Go to Right Window";
          remap = true;
        };
      }

      # Resize window using <ctrl> arrow keys
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<cr>";
        options.desc = "Increase Window Height";
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<cr>";
        options.desc = "Decrease Window Height";
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize -2<cr>";
        options.desc = "Decrease Window Width";
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize +2<cr>";
        options.desc = "Increase Window Width";
      }

      # Move Lines
      {
        mode = "n";
        key = "<A-j>";
        action = "<cmd>execute 'move .+' . v:count1<cr>==";
        options.desc = "Move Down";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
        options.desc = "Move Up";
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
        mode = "x";
        key = "<A-j>";
        action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
        options.desc = "Move Down";
      }
      {
        mode = "x";
        key = "<A-k>";
        action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
        options.desc = "Move Up";
      }

      # Buffers
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprevious<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = "n";
        key = "[b";
        action = "<cmd>bprevious<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "]b";
        action = "<cmd>bnext<cr>";
        options.desc = "Next Buffer";
      }
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
        action.__raw = "function() Snacks.bufdelete() end";
        options.desc = "Delete Buffer";
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>:bd<cr>";
        options.desc = "Delete Buffer and Window";
      }

      # Clear search with <esc>
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

      # Clear search, diff update and redraw
      {
        mode = "n";
        key = "<leader>ur";
        action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
        options.desc = "Redraw / Clear hlsearch / Diff Update";
      }

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

      # Add undo break-points
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

      # Save file
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

      # Keywordprg
      {
        mode = "n";
        key = "<leader>K";
        action = "<cmd>norm! K<cr>";
        options.desc = "Keywordprg";
      }

      # Better indenting
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

      # Commenting
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

      # New file
      {
        mode = "n";
        key = "<leader>fn";
        action = "<cmd>enew<cr>";
        options.desc = "New File";
      }

      # Location and quickfix list
      {
        mode = "n";
        key = "<leader>xl";
        action = "<cmd>lopen<cr>";
        options.desc = "Location List";
      }
      {
        mode = "n";
        key = "<leader>xq";
        action = "<cmd>copen<cr>";
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

      # Diagnostic navigation
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

      # Toggle options
      {
        mode = "n";
        key = "<leader>us";
        action = "<cmd>set spell!<cr>";
        options.desc = "Toggle Spelling";
      }
      {
        mode = "n";
        key = "<leader>uw";
        action = "<cmd>set wrap!<cr>";
        options.desc = "Toggle Wrap";
      }
      {
        mode = "n";
        key = "<leader>uL";
        action = "<cmd>set relativenumber!<cr>";
        options.desc = "Toggle Relative Number";
      }
      {
        mode = "n";
        key = "<leader>ul";
        action = "<cmd>set number!<cr>";
        options.desc = "Toggle Line Numbers";
      }
      {
        mode = "n";
        key = "<leader>ud";
        action.__raw = ''
          function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
          end
        '';
        options.desc = "Toggle Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>uc";
        action.__raw = ''
          function()
            if vim.o.conceallevel > 0 then
              vim.o.conceallevel = 0
            else
              vim.o.conceallevel = 2
            end
          end
        '';
        options.desc = "Toggle Conceal Level";
      }
      {
        mode = "n";
        key = "<leader>ug";
        action.__raw = "function() Snacks.toggle.indent():toggle() end";
        options.desc = "Toggle Indent Guides";
      }
      {
        mode = "n";
        key = "<leader>uT";
        action.__raw = "function() Snacks.toggle.treesitter():toggle() end";
        options.desc = "Toggle Treesitter Highlight";
      }

      # Quit
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>qa<cr>";
        options.desc = "Quit All";
      }

      # Highlights under cursor
      {
        mode = "n";
        key = "<leader>ui";
        action.__raw = "vim.show_pos";
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

      # Windows
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

      # Tabs
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
