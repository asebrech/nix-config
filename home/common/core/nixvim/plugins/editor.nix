# editor plugins
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      # flash enhances the built-in search functionality by showing labels
      # at the end of each match, letting you quickly jump to a specific location
      flash = {
        enable = true;
        settings = {
          labels = "asdfghjklqwertyuiopzxcvbnm";
          search = {
            mode = "exact";
            incremental = true;
          };
          jump = {
            autojump = true;
          };
          modes = {
            char = {
              enabled = true;
              jump_labels = true;
              multi_line = false;
            };
            search = {
              enabled = false;
            };
            treesitter = {
              labels = "asdfghjklqwertyuiopzxcvbnm";
              jump = {
                pos = "range";
              };
              search = {
                incremental = false;
              };
              label = {
                before = true;
                after = true;
                style = "inline";
              };
            };
          };
          label = {
            uppercase = false;
            rainbow = {
              enabled = false;
              shade = 5;
            };
          };
        };
      };

      # which-key helps you remember key bindings by showing a popup
      # with the active keybindings of the command you started typing
      which-key = {
        enable = true;
        settings = {
          preset = "modern";
          delay = 200;
          icons = {
            breadcrumb = "»";
            separator = "➜";
            group = "+";
            mappings = true;
            rules = [ ];
            colors = true;
          };
          spec = [
            {
              __unkeyed-1 = "<leader><tab>";
              group = "tabs";
            }
            {
              __unkeyed-1 = "<leader>b";
              group = "buffer";
              expand.__raw = ''function() return require("which-key.extras").expand.buf() end'';
            }
            {
              __unkeyed-1 = "<leader>c";
              group = "code";
            }
            {
              __unkeyed-1 = "<leader>d";
              group = "debug";
            }
            {
              __unkeyed-1 = "<leader>dp";
              group = "profiler";
            }
            {
              __unkeyed-1 = "<leader>f";
              group = "file/find";
            }
            {
              __unkeyed-1 = "<leader>g";
              group = "git";
            }
            {
              __unkeyed-1 = "<leader>gh";
              group = "hunks";
            }
            {
              __unkeyed-1 = "<leader>q";
              group = "quit/session";
            }
            {
              __unkeyed-1 = "<leader>s";
              group = "search";
            }
            {
              __unkeyed-1 = "<leader>u";
              group = "ui";
            }
            {
              __unkeyed-1 = "<leader>w";
              group = "windows";
              proxy = "<c-w>";
              expand.__raw = ''function() return require("which-key.extras").expand.win() end'';
            }
            {
              __unkeyed-1 = "<leader>x";
              group = "diagnostics/quickfix";
            }
            {
              __unkeyed-1 = "[";
              group = "prev";
            }
            {
              __unkeyed-1 = "]";
              group = "next";
            }
            {
              __unkeyed-1 = "g";
              group = "goto";
            }
            {
              __unkeyed-1 = "gs";
              group = "surround";
            }
            {
              __unkeyed-1 = "gx";
              desc = "Open with system app";
            }
            {
              __unkeyed-1 = "z";
              group = "fold";
            }
            # mini.ai textobjects
            {
              __unkeyed-1 = "a=";
              mode = [
                "o"
                "x"
              ];
              desc = "Around Assignment Statement";
            }
            {
              __unkeyed-1 = "i=";
              mode = [
                "o"
                "x"
              ];
              desc = "Inside Assignment Statement";
            }
            {
              __unkeyed-1 = "ac";
              mode = [
                "o"
                "x"
              ];
              desc = "Around Class";
            }
            {
              __unkeyed-1 = "ic";
              mode = [
                "o"
                "x"
              ];
              desc = "Inside Class";
            }
            {
              __unkeyed-1 = "ad";
              mode = [
                "o"
                "x"
              ];
              desc = "Around Digit(s)";
            }
            {
              __unkeyed-1 = "id";
              mode = [
                "o"
                "x"
              ];
              desc = "Inside Digit(s)";
            }
            {
              __unkeyed-1 = "ae";
              mode = [
                "o"
                "x"
              ];
              desc = "Around Word Segment";
            }
            {
              __unkeyed-1 = "ie";
              mode = [
                "o"
                "x"
              ];
              desc = "Inside Word Segment";
            }
            {
              __unkeyed-1 = "af";
              mode = [
                "o"
                "x"
              ];
              desc = "Around Function";
            }
            {
              __unkeyed-1 = "if";
              mode = [
                "o"
                "x"
              ];
              desc = "Inside Function";
            }
            {
              __unkeyed-1 = "ag";
              mode = [
                "o"
                "x"
              ];
              desc = "Around Buffer";
            }
            {
              __unkeyed-1 = "ig";
              mode = [
                "o"
                "x"
              ];
              desc = "Inside Buffer";
            }
            {
              __unkeyed-1 = "ao";
              mode = [
                "o"
                "x"
              ];
              desc = "Around Block/Conditional/Loop";
            }
            {
              __unkeyed-1 = "io";
              mode = [
                "o"
                "x"
              ];
              desc = "Inside Block/Conditional/Loop";
            }
            {
              __unkeyed-1 = "at";
              mode = [
                "o"
                "x"
              ];
              desc = "Around Tag";
            }
            {
              __unkeyed-1 = "it";
              mode = [
                "o"
                "x"
              ];
              desc = "Inside Tag";
            }
            {
              __unkeyed-1 = "au";
              mode = [
                "o"
                "x"
              ];
              desc = "Around Function Call";
            }
            {
              __unkeyed-1 = "iu";
              mode = [
                "o"
                "x"
              ];
              desc = "Inside Function Call";
            }
            {
              __unkeyed-1 = "aU";
              mode = [
                "o"
                "x"
              ];
              desc = "Around Function Call (Strict)";
            }
            {
              __unkeyed-1 = "iU";
              mode = [
                "o"
                "x"
              ];
              desc = "Inside Function Call (Strict)";
            }
          ];
        };
      };

      # git signs highlights text that has changed since the list
      # git commit, and also lets you interactively stage & unstage
      # hunks in a commit
      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add = {
              text = "▎";
            };
            change = {
              text = "▎";
            };
            delete = {
              text = "";
            };
            topdelete = {
              text = "";
            };
            changedelete = {
              text = "▎";
            };
            untracked = {
              text = "▎";
            };
          };
          signs_staged = {
            add = {
              text = "▎";
            };
            change = {
              text = "▎";
            };
            delete = {
              text = "";
            };
            topdelete = {
              text = "";
            };
            changedelete = {
              text = "▎";
            };
          };
          on_attach = {
            __raw = ''
              function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                  vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
                end

                map("n", "]h", function()
                  if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                  else
                    gs.nav_hunk("next")
                  end
                end, "Next Hunk")
                map("n", "[h", function()
                  if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                  else
                    gs.nav_hunk("prev")
                  end
                end, "Prev Hunk")
                map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
                map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
                map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
              end
            '';
          };
        };
      };

      # better diagnostics list and others
      trouble = {
        enable = true;
        settings = {
          modes = {
            lsp = {
              win = {
                position = "right";
              };
            };
          };
        };
      };

      # fuzzy finder
      telescope = {
        enable = true;
        settings = {
          defaults = {
            prompt_prefix = " ";
            selection_caret = " ";
            get_selection_window.__raw = ''
              function()
                local wins = vim.api.nvim_list_wins()
                table.insert(wins, 1, vim.api.nvim_get_current_win())
                for _, win in ipairs(wins) do
                  local buf = vim.api.nvim_win_get_buf(win)
                  if vim.bo[buf].buftype == "" then
                    return win
                  end
                end
                return 0
              end
            '';
            mappings = {
              i = {
                "<c-t>" = {
                  __raw = ''require("trouble.sources.telescope").open'';
                };
                "<C-Down>" = {
                  __raw = ''require("telescope.actions").cycle_history_next'';
                };
                "<C-Up>" = {
                  __raw = ''require("telescope.actions").cycle_history_prev'';
                };
                "<C-f>" = {
                  __raw = ''require("telescope.actions").preview_scrolling_down'';
                };
                "<C-b>" = {
                  __raw = ''require("telescope.actions").preview_scrolling_up'';
                };
              };
              n = {
                q = {
                  __raw = ''require("telescope.actions").close'';
                };
              };
            };
          };
        };
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };
        keymaps = {
          # find
          "<leader><space>" = {
            action = "find_files";
            options.desc = "Find Files (Root Dir)";
          };
          "<leader>," = {
            action = "buffers";
            options.desc = "Switch Buffer";
          };
          "<leader>/" = {
            action = "live_grep";
            options.desc = "Grep (Root Dir)";
          };
          "<leader>:" = {
            action = "command_history";
            options.desc = "Command History";
          };
          "<leader>fb" = {
            action = "buffers";
            options.desc = "Buffers";
          };
          "<leader>fc" = {
            action = "find_files";
            options.desc = "Find Config File";
          };
          "<leader>ff" = {
            action = "find_files";
            options.desc = "Find Files (Root Dir)";
          };
          "<leader>fF" = {
            action = "find_files";
            options.desc = "Find Files (cwd)";
          };
          "<leader>fg" = {
            action = "git_files";
            options.desc = "Find Files (git-files)";
          };
          "<leader>fr" = {
            action = "oldfiles";
            options.desc = "Recent";
          };
          # git
          "<leader>gc" = {
            action = "git_commits";
            options.desc = "Commits";
          };
          "<leader>gs" = {
            action = "git_status";
            options.desc = "Status";
          };
          # search
          "<leader>s\"" = {
            action = "registers";
            options.desc = "Registers";
          };
          "<leader>sa" = {
            action = "autocommands";
            options.desc = "Auto Commands";
          };
          "<leader>sb" = {
            action = "current_buffer_fuzzy_find";
            options.desc = "Buffer";
          };
          "<leader>sc" = {
            action = "command_history";
            options.desc = "Command History";
          };
          "<leader>sC" = {
            action = "commands";
            options.desc = "Commands";
          };
          "<leader>sd" = {
            action = "diagnostics bufnr=0";
            options.desc = "Document Diagnostics";
          };
          "<leader>sD" = {
            action = "diagnostics";
            options.desc = "Workspace Diagnostics";
          };
          "<leader>sg" = {
            action = "live_grep";
            options.desc = "Grep (Root Dir)";
          };
          "<leader>sG" = {
            action = "live_grep";
            options.desc = "Grep (cwd)";
          };
          "<leader>sh" = {
            action = "help_tags";
            options.desc = "Help Pages";
          };
          "<leader>sH" = {
            action = "highlights";
            options.desc = "Search Highlight Groups";
          };
          "<leader>sj" = {
            action = "jumplist";
            options.desc = "Jumplist";
          };
          "<leader>sk" = {
            action = "keymaps";
            options.desc = "Key Maps";
          };
          "<leader>sl" = {
            action = "loclist";
            options.desc = "Location List";
          };
          "<leader>sM" = {
            action = "man_pages";
            options.desc = "Man Pages";
          };
          "<leader>sm" = {
            action = "marks";
            options.desc = "Jump to Mark";
          };
          "<leader>so" = {
            action = "vim_options";
            options.desc = "Options";
          };
          "<leader>sR" = {
            action = "resume";
            options.desc = "Resume";
          };
          "<leader>sq" = {
            action = "quickfix";
            options.desc = "Quickfix List";
          };
          "<leader>sw" = {
            action = "grep_string";
            options.desc = "Word (Root Dir)";
          };
          "<leader>sW" = {
            action = "grep_string";
            options.desc = "Word (cwd)";
          };
          "<leader>uC" = {
            action = "colorscheme";
            options.desc = "Colorscheme with Preview";
          };
          # lsp
          "<leader>ss" = {
            action = "lsp_document_symbols";
            options.desc = "Goto Symbol";
          };
          "<leader>sS" = {
            action = "lsp_dynamic_workspace_symbols";
            options.desc = "Goto Symbol (Workspace)";
          };
        };
      };

      # search/replace in multiple files
      grug-far = {
        enable = true;
        settings = {
          headerMaxWidth = 80;
        };
      };

      # session management
      persistence = {
        enable = true;
        settings = { };
      };

      # file explorer
      neo-tree = {
        enable = true;
        settings = {
          sources = [
            "filesystem"
            "buffers"
            "git_status"
          ];
          open_files_do_not_replace_types = [
            "terminal"
            "Trouble"
            "trouble"
            "qf"
            "Outline"
          ];
          filesystem = {
            bind_to_cwd = false;
            follow_current_file = {
              enabled = true;
            };
            use_libuv_file_watcher = true;
          };
          window = {
            position = "left";
            width = 30;
            mappings = {
              "<space>" = "none";
              Y = {
                __raw = ''
                  function(state)
                    local node = state.tree:get_node()
                    local path = node:get_id()
                    vim.fn.setreg("+", path, "c")
                  end
                '';
              };
              O = {
                __raw = ''
                  function(state)
                    vim.ui.open(state.tree:get_node().path)
                  end
                '';
              };
              P = {
                command = "toggle_preview";
                config = {
                  use_float = true;
                };
              };
            };
          };
          default_component_configs = {
            indent = {
              with_expanders = true;
              expander_collapsed = "";
              expander_expanded = "";
              expander_highlight = "NeoTreeExpander";
            };
            git_status = {
              symbols = {
                unstaged = "󰄱";
                staged = "󰱒";
              };
            };
          };
        };
      };
    };

    # flash keymaps
    keymaps = [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action.__raw = ''function() require("flash").jump() end'';
        options.desc = "Flash";
      }
      {
        mode = [
          "n"
          "o"
          "x"
        ];
        key = "S";
        action.__raw = ''function() require("flash").treesitter() end'';
        options.desc = "Flash Treesitter";
      }
      {
        mode = "o";
        key = "r";
        action.__raw = ''function() require("flash").remote() end'';
        options.desc = "Remote Flash";
      }
      {
        mode = [
          "o"
          "x"
        ];
        key = "R";
        action.__raw = ''function() require("flash").treesitter_search() end'';
        options.desc = "Treesitter Search";
      }
      {
        mode = "c";
        key = "<c-s>";
        action.__raw = ''function() require("flash").toggle() end'';
        options.desc = "Toggle Flash Search";
      }
      {
        mode = [
          "n"
          "o"
          "x"
        ];
        key = "<c-space>";
        action.__raw = ''
          function()
            require("flash").treesitter({
              actions = {
                ["<c-space>"] = "next",
                ["<BS>"] = "prev",
              },
            })
          end
        '';
        options.desc = "Treesitter Incremental Selection";
      }
      # trouble keymaps
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options.desc = "Buffer Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle<cr>";
        options.desc = "Symbols (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cS";
        action = "<cmd>Trouble lsp toggle<cr>";
        options.desc = "LSP references/definitions/... (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        options.desc = "Location List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        options.desc = "Quickfix List (Trouble)";
      }
      {
        mode = "n";
        key = "[q";
        action.__raw = ''
          function()
            if require("trouble").is_open() then
              require("trouble").prev({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cprev)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '';
        options.desc = "Previous Trouble/Quickfix Item";
      }
      {
        mode = "n";
        key = "]q";
        action.__raw = ''
          function()
            if require("trouble").is_open() then
              require("trouble").next({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cnext)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '';
        options.desc = "Next Trouble/Quickfix Item";
      }
      # neo-tree keymaps
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Explorer NeoTree (Root Dir)";
      }
      {
        mode = "n";
        key = "<leader>E";
        action = "<cmd>Neotree toggle dir=.<cr>";
        options.desc = "Explorer NeoTree (cwd)";
      }
      {
        mode = "n";
        key = "<leader>fe";
        action = "<leader>e";
        options = {
          desc = "Explorer NeoTree (Root Dir)";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fE";
        action = "<leader>E";
        options = {
          desc = "Explorer NeoTree (cwd)";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ge";
        action = "<cmd>Neotree git_status<cr>";
        options.desc = "Git Explorer";
      }
      {
        mode = "n";
        key = "<leader>be";
        action = "<cmd>Neotree buffers<cr>";
        options.desc = "Buffer Explorer";
      }
      # grug-far keymaps
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>sr";
        action.__raw = ''
          function()
            local grug = require("grug-far")
            local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
            grug.open({
              transient = true,
              prefills = {
                filesFilter = ext and ext ~= "" and "*." .. ext or nil,
              },
            })
          end
        '';
        options.desc = "Search and Replace";
      }
      # session keymaps
      {
        mode = "n";
        key = "<leader>qs";
        action.__raw = ''function() require("persistence").load() end'';
        options.desc = "Restore Session";
      }
      {
        mode = "n";
        key = "<leader>qS";
        action.__raw = ''function() require("persistence").select() end'';
        options.desc = "Select Session";
      }
      {
        mode = "n";
        key = "<leader>ql";
        action.__raw = ''function() require("persistence").load({ last = true }) end'';
        options.desc = "Restore Last Session";
      }
      {
        mode = "n";
        key = "<leader>qd";
        action.__raw = ''function() require("persistence").stop() end'';
        options.desc = "Don't Save Current Session";
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
    ];

    # gitsigns toggle
    extraConfigLua = ''
      Snacks.toggle({
        name = "Git Signs",
        get = function() return require("gitsigns.config").config.signcolumn end,
        set = function(state) require("gitsigns").toggle_signs(state) end,
      }):map("<leader>uG")
    '';
  };
}
