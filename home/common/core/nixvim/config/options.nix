# LazyVim-style options for nixvim
# Theming is handled by stylix
{ ... }:
{
  programs.nixvim = {
    # Leader keys
    globals = {
      mapleader = " ";
      maplocalleader = "\\";

      # LazyVim auto format
      autoformat = true;

      # Snacks animations
      snacks_animate = true;

      # Fix markdown indentation settings
      markdown_recommended_style = 0;

      # LazyVim root dir detection
      # Each entry can be:
      # * the name of a detector function like `lsp` or `cwd`
      # * a pattern or array of patterns like `.git` or `lua`.
      root_spec = [
        "lsp"
        [
          ".git"
          "lua"
        ]
        "cwd"
      ];

      # Set LSP servers to be ignored when used for detecting the LSP root
      root_lsp_ignore = [ "copilot" ];
    };

    opts = {
      # General
      autowrite = true; # Enable auto write

      # Clipboard - sync with system clipboard
      clipboard = "unnamedplus";

      # Completion
      completeopt = "menu,menuone,noselect";

      # Concealing
      conceallevel = 2;

      # Confirmation
      confirm = true; # Confirm to save changes before exiting modified buffer

      # Cursor
      cursorline = true; # Enable highlighting of the current line

      # Diff
      fillchars = {
        foldopen = "";
        foldclose = "";
        fold = " ";
        foldsep = " ";
        diff = "╱";
        eob = " ";
      };

      # Folding
      foldlevel = 99;
      foldtext = "";

      # Format options
      formatoptions = "jcroqlnt";
      formatexpr = "v:lua.require'conform'.formatexpr()";

      # Grep
      grepformat = "%f:%l:%c:%m";
      grepprg = "rg --vimgrep";

      # Search
      ignorecase = true; # Ignore case
      smartcase = true; # Don't ignore case with capitals
      inccommand = "nosplit"; # Preview incremental substitute

      # Jumps
      jumpoptions = "view";

      # Status line
      laststatus = 3; # Global statusline

      # Line breaks
      linebreak = true; # Wrap lines at convenient points

      # List characters
      list = true; # Show some invisible characters

      # Mouse
      mouse = "a"; # Enable mouse mode

      # Line numbers
      number = true; # Print line number
      relativenumber = true; # Relative line numbers

      # Popup menu
      pumblend = 10; # Popup blend
      pumheight = 10; # Maximum number of entries in a popup

      # Ruler
      ruler = false; # Disable the default ruler

      # Scroll
      scrolloff = 4; # Lines of context
      sidescrolloff = 8; # Columns of context
      smoothscroll = true;

      # Session options
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

      # Indentation
      shiftround = true; # Round indent
      shiftwidth = 2; # Size of an indent
      tabstop = 2; # Number of spaces tabs count for
      expandtab = true; # Use spaces instead of tabs
      smartindent = true; # Insert indents automatically

      # Short messages
      shortmess = "filnxtToOFWIcC";

      # Mode display
      showmode = false; # Don't show mode since we have a statusline

      # Sign column
      signcolumn = "yes"; # Always show the signcolumn

      # Spelling
      spelllang = [ "en" ];

      # Splits
      splitbelow = true; # Put new windows below current
      splitkeep = "screen";
      splitright = true; # Put new windows right of current

      # Terminal colors
      termguicolors = true; # True color support

      # Timeout
      timeoutlen = 300; # Lower than default (1000) to quickly trigger which-key

      # Undo
      undofile = true;
      undolevels = 10000;

      # Update time
      updatetime = 200; # Save swap file and trigger CursorHold

      # Virtual edit
      virtualedit = "block"; # Allow cursor to move where there is no text in visual block mode

      # Wild mode
      wildmode = "longest:full,full"; # Command-line completion mode

      # Window
      winminwidth = 5; # Minimum window width
      wrap = false; # Disable line wrap
    };
  };
}
