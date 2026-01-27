# Core home-manager configuration for all NixOS hosts
{
  config,
  lib,
  pkgs,
  hostSpec,
  ...
}:
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common/host-spec.nix"
      "modules/home"
    ])
    ./nixos.nix

    ./direnv.nix
    ./git.nix
    ./alacritty.nix
    ./nixvim
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

  home.packages = builtins.attrValues {
    inherit (pkgs)

      # Packages that don't have custom configs go here
      btop # system monitor
      curl
      pciutils
      pfetch # system info
      pre-commit # git hooks
      p7zip # compression & encryption
      ripgrep # better grep
      usbutils
      unzip # zip extraction
      unrar # rar extraction
      foot # wayland terminal
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

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
