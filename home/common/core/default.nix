# Core home-manager configuration for all NixOS hosts
{
  config,
  lib,
  pkgs,
  inputs,
  hostSpec,
  ...
}:
{
  imports = lib.flatten [
    (lib.custom.relativeToRoot "modules/common/host-spec.nix")
    ./nixos.nix

    ./direnv.nix
    ./git.nix
    ./ghostty.nix
    ./ssh.nix
    ./starship.nix
    ./zsh
  ];

  inherit hostSpec;

  services.ssh-agent.enable = true;

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    stateVersion = lib.mkDefault "25.11";
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  home.packages =
    builtins.attrValues {
      inherit (pkgs)
        btop # system monitor
        curl
        lazygit # git TUI
        neovim # editor, stock config
        pciutils
        pfetch # system info
        pre-commit # git hooks
        p7zip # compression & encryption
        ripgrep # better grep
        usbutils
        unzip # zip extraction
        unrar # rar extraction
        wl-clipboard # wayland clipboard CLI (nvim/tmux clipboard provider)
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
      ];
      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
