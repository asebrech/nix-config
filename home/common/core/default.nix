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
        bat # better cat
        btop # system monitor
        curl
        duf # better df
        dust # better du
        eza # better ls (also used by the iso-install recipe)
        fastfetch # system info
        fd # better find
        gping # ping with a live graph
        glow # markdown reader
        hyperfine # command benchmarking
        jq # json processor
        lazygit # git TUI
        helix # editor, stock config
        pciutils
        procs # better ps
        p7zip # compression & encryption
        ripgrep # better grep
        sd # simpler sed for interactive use
        tlrc # tldr pages
        usbutils
        unzip # zip extraction
        unrar # rar extraction
        watchexec # rerun a command on file changes
        wl-clipboard # wayland clipboard CLI (helix/zellij clipboard provider)
        yazi # terminal file manager
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
