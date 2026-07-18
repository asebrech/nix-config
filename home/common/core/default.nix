# Core home-manager configuration for all NixOS hosts
{
  lib,
  pkgs,
  inputs,
  hostSpec,
  ...
}:
{
  imports = lib.flatten [
    (lib.custom.relativeToRoot "modules/hosts/common/host-spec.nix")
    (lib.custom.scanPaths ./.)
  ];

  inherit hostSpec;

  services.ssh-agent.enable = true;

  home = {
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  home.packages =
    lib.attrValues {
      inherit (pkgs)
        btop # system monitor
        curl
        fastfetch # system info
        lazygit # git TUI
        helix # editor, stock config
        pciutils
        p7zip # compression & encryption
        ripgrep # better grep
        usbutils
        unzip # zip extraction
        unrar # rar extraction
        wl-clipboard # wayland clipboard CLI (helix/zellij clipboard provider)
        ;
    }
    ++ [
      inputs.devenv.packages.${pkgs.system}.devenv # development environment management
    ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
