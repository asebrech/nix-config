{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    (lib.custom.scanPaths ./.)
    (map lib.custom.relativeToRoot [
      "modules/home"
    ])
  ];

  home = {
    username = lib.mkDefault "exampleSecondUser";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.11";
    sessionPath = [ "$HOME/.local/bin" ];
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)

      # Packages that don't have custom configs go here
      nix-tree
      ;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
