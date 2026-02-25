# nix
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      lsp.servers = {
        nil_ls = {
          enable = true;
          settings = {
            formatting = {
              command = [ "nixfmt" ];
            };
            nix = {
              flake = {
                autoArchive = true;
              };
            };
          };
        };
      };

      lint.lintersByFt.nix = [ "statix" ];
    };

    extraPackages = with pkgs; [ statix ];

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
