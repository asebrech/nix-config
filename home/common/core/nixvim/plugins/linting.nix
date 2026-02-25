# linting
{ ... }:
{
  programs.nixvim = {
    plugins = {
      # nvim-lint runs linters on save and buffer read
      lint = {
        enable = true;
        lintersByFt = {
          fish = [ "fish" ];
        };

        autoCmd = {
          event = [
            "BufWritePost"
            "BufReadPost"
            "InsertLeave"
          ];
          callback.__raw = ''
            function()
              require("lint").try_lint()
            end
          '';
        };
      };
    };
  };
}
