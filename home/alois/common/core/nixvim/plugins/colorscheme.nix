# LazyVim plugins/colorscheme.nix - Colorscheme configuration
# Note: Theming is handled by stylix, so we don't set a colorscheme here
{ ... }:
{
  programs.nixvim = {
    # Colorscheme is handled by stylix
    # If you want to use a specific colorscheme, uncomment and configure:
    # colorschemes.tokyonight = {
    #   enable = true;
    #   settings = {
    #     style = "moon";
    #     transparent = false;
    #     terminal_colors = true;
    #     styles = {
    #       comments = { italic = true; };
    #       keywords = { italic = true; };
    #       functions = {};
    #       variables = {};
    #       sidebars = "dark";
    #       floats = "dark";
    #     };
    #     dim_inactive = false;
    #   };
    # };

    # Alternative colorschemes available:
    # colorschemes.catppuccin.enable = true;
    # colorschemes.gruvbox.enable = true;
    # colorschemes.nord.enable = true;
    # colorschemes.onedark.enable = true;

    # Stylix will automatically configure the colorscheme
    # based on your system-wide theme configuration
  };
}
