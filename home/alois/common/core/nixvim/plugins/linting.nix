# LazyVim plugins/linting.nix - Code linting
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # nvim-lint - Linting
      lint = {
        enable = true;
        lintersByFt = {
          fish = [ "fish" ];
          # Add more linters as needed
          # javascript = [ "eslint_d" ];
          # typescript = [ "eslint_d" ];
          # python = [ "ruff" ];
          # sh = [ "shellcheck" ];
          # markdown = [ "markdownlint" ];
        };

        autoCmd = {
          event = [
            "BufWritePost"
            "BufReadPost"
            "InsertLeave"
          ];
          callback.__raw = ''
            function()
              -- try_lint without arguments runs the linters defined in `linters_by_ft`
              -- for the current filetype
              require("lint").try_lint()
            end
          '';
        };
      };
    };
  };
}
