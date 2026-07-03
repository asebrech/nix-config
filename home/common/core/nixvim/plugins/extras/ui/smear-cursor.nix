# smear-cursor
{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "smear-cursor";
        src = pkgs.fetchFromGitHub {
          owner = "sphamba";
          repo = "smear-cursor.nvim";
          rev = "9e9378d6ee34bb3782e0e8c63d9ec8ca618b479b";
          hash = "sha256-hL0lXzkFxR7qiXzStrmY+gR+ql/A6PR8eCV310gEaGs=";
        };
      })
    ];

    extraConfigLua = ''
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
        key = "<leader>uM";
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
