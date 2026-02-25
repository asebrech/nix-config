# options
{ ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
      autoformat = true;
      snacks_animate = true;
      markdown_recommended_style = 0;
      deprecation_warnings = false;
      trouble_lualine = true;
      root_spec = [
        "lsp"
        [
          ".git"
          "lua"
        ]
        "cwd"
      ];
      root_lsp_ignore = [ "copilot" ];
    };

    opts = {
      autowrite = true; # enable auto write
      clipboard.__raw = ''vim.env.SSH_CONNECTION and "" or "unnamedplus"''; # sync with system clipboard
      completeopt = "menu,menuone,noselect"; # completion options
      conceallevel = 2; # hide * markup for bold and italic, but not markers with substitutions
      confirm = true; # confirm to save changes before exiting modified buffer
      cursorline = true; # enable highlighting of the current line
      expandtab = true; # use spaces instead of tabs
      # fillchars set via extraConfigLua to avoid glyph encoding issues
      foldlevel = 99; # using ufo provider need a large value
      foldmethod = "indent"; # overridden per-buffer by treesitter folding
      foldtext = ""; # use treesitter foldtext
      formatexpr = "v:lua.require'conform'.formatexpr()";
      formatoptions = "jcroqlnt"; # default format options
      grepformat = "%f:%l:%c:%m";
      grepprg = "rg --vimgrep";
      ignorecase = true; # ignore case
      inccommand = "nosplit"; # preview incremental substitute
      jumpoptions = "view"; # restore view on jump
      laststatus = 3; # global statusline
      linebreak = true; # wrap lines at convenient points
      list = true; # show some invisible characters
      mouse = "a"; # enable mouse mode
      number = true; # print line number
      pumblend = 10; # popup blend
      pumheight = 10; # maximum number of entries in a popup
      relativenumber = true; # relative line numbers
      ruler = false; # disable the default ruler
      scrolloff = 4; # lines of context
      sessionoptions = [
        "buffers"
        "curdir"
        "tabpages"
        "winsize"
        "help"
        "globals"
        "skiprtp"
        "folds"
      ];
      shiftround = true; # round indent
      shiftwidth = 2; # size of an indent
      shortmess = "filnxtToOFWIcC"; # suppress various messages
      showmode = false; # dont show mode since we have a statusline
      sidescrolloff = 8; # columns of context
      signcolumn = "yes"; # always show the signcolumn
      smartcase = true; # don't ignore case with capitals
      smartindent = true; # insert indents automatically
      smoothscroll = true; # smooth scrolling for <C-d>/<C-u>
      spelllang = [ "en" ];
      splitbelow = true; # put new windows below current
      splitkeep = "screen"; # reduce scroll during split resize
      splitright = true; # put new windows right of current
      tabstop = 2; # number of spaces tabs count for
      termguicolors = true; # true color support
      timeoutlen = 300; # lower than default (1000) to quickly trigger which-key
      undofile = true; # persistent undo
      undolevels = 10000;
      updatetime = 200; # save swap file and trigger CursorHold
      virtualedit = "block"; # allow cursor to move where there is no text in visual block mode
      wildmode = "longest:full,full"; # command-line completion mode
      winminwidth = 5; # minimum window width
      wrap = false; # disable line wrap
    };

    extraConfigLua = ''
      -- fillchars
      vim.opt.fillchars = {
        foldopen  = "",
        foldclose = "",
        fold      = " ",
        foldsep   = " ",
        diff      = "╱",
        eob       = " ",
      }
    '';
  };
}
