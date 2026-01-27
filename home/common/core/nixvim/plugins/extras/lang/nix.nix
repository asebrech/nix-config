# Nix language support
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      # LSP
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

    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
