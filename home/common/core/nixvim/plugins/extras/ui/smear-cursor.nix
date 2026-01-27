# Smear cursor - Animated cursor effect
{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "smear-cursor";
        src = pkgs.fetchFromGitHub {
          owner = "sphamba";
          repo = "smear-cursor.nvim";
          rev = "main";
          sha256 = "1fsd7wz7bls623a60ia0j1ssw6wi4vrf9xzq41zl3m6540bgsgjk";
        };
      })
    ];

    extraConfigLua = ''
      -- Smear cursor configuration
      -- Note: You may need to update the hash above
      local ok, smear = pcall(require, "smear_cursor")
      if ok then
        smear.setup({
          stiffness = 0.8,
          trailing_stiffness = 0.5,
          distance_stop_animating = 0.5,
          hide_target_hack = false,
        })
      end
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>uS";
        action.__raw = ''
          function()
            local ok, smear = pcall(require, "smear_cursor")
            if ok then
              smear.toggle()
            end
          end
        '';
        options.desc = "Toggle Smear Cursor";
      }
    ];
  };
}
