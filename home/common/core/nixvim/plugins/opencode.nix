# AI coding assistant integration
# https://github.com/NickvanDyke/opencode.nvim
{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.opencode-nvim
    ];

    extraConfigLua = ''
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- server defaults: uses built-in opencode.terminal (singleton, no duplicate-instance bug)
      }

      -- Required for opts.events.reload (checktime needs autoread to actually reload buffers)
      vim.o.autoread = true
    '';

    keymaps = [
      {
        mode = [
          "n"
          "x"
        ];
        key = "<C-a>";
        action.__raw = ''
          function()
            require("opencode").ask("@this: ", { submit = true })
          end
        '';
        options = {
          desc = "Ask opencode…";
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<C-x>";
        action.__raw = ''
          function()
            require("opencode").select()
          end
        '';
        options = {
          desc = "Execute opencode action…";
        };
      }
      {
        mode = [
          "n"
          "t"
        ];
        key = "<C-.>";
        action.__raw = ''
          function()
            require("opencode").toggle()
          end
        '';
        options = {
          desc = "Toggle opencode";
        };
      }
      # operator() supports ranges and dot-repeat (replaces prompt("@this"))
      {
        mode = [
          "n"
          "x"
        ];
        key = "go";
        action.__raw = ''
          function()
            return require("opencode").operator("@this ")
          end
        '';
        options = {
          desc = "Add range to opencode";
          expr = true;
        };
      }
      {
        mode = [ "n" ];
        key = "goo";
        action.__raw = ''
          function()
            return require("opencode").operator("@this ") .. "_"
          end
        '';
        options = {
          desc = "Add line to opencode";
          expr = true;
        };
      }
      # Scroll opencode from any buffer
      {
        mode = [ "n" ];
        key = "<S-C-u>";
        action.__raw = ''
          function()
            require("opencode").command("session.half.page.up")
          end
        '';
        options = {
          desc = "Scroll opencode up";
        };
      }
      {
        mode = [ "n" ];
        key = "<S-C-d>";
        action.__raw = ''
          function()
            require("opencode").command("session.half.page.down")
          end
        '';
        options = {
          desc = "Scroll opencode down";
        };
      }
      # Remap increment/decrement since we use <C-a> and <C-x>
      {
        mode = [ "n" ];
        key = "+";
        action = "<C-a>";
        options = {
          desc = "Increment under cursor";
          noremap = true;
        };
      }
      {
        mode = [ "n" ];
        key = "-";
        action = "<C-x>";
        options = {
          desc = "Decrement under cursor";
          noremap = true;
        };
      }
    ];
  };
}
