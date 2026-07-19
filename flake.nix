{
  description = "asebrech's Nix-Config";
  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
      nix-secrets,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
      namespace = "asebrech"; # namespace for our custom modules. Snowfall lib style

      customLib = nixpkgs.lib.extend (
        _self: _super: {
          custom = import ./lib { inherit (nixpkgs) lib; };
        }
      );

      secrets = nix-secrets.mkSecrets nixpkgs customLib;

      mkHost = host: {
        ${host} =
          # Propagate lib.custom into hm
          # see: https://github.com/nix-community/home-manager/pull/3454
          lib.nixosSystem {
            specialArgs = {
              inherit
                inputs
                outputs
                namespace
                secrets
                ;
              lib = customLib;
            };
            modules = [
              ./hosts/nixos/${host}
            ];
          };
      };

      mkHostConfigs = hosts: lib.foldl (acc: set: acc // set) { } (lib.map mkHost hosts);
      readHosts = folder: lib.attrNames (lib.readDir ./hosts/${folder});

    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        # Custom modifications/overrides to upstream packages
        overlays = import ./overlays {
          inherit inputs lib secrets;
        };
        # Build host configs
        nixosConfigurations = mkHostConfigs (readHosts "nixos");
      };
      systems = [
        "aarch64-linux"
      ];
      perSystem =
        { system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
            config.allowUnfree = true;
          };
          formatter = pkgs.nixfmt-rfc-style;
        in
        rec {
          # Expose custom packages
          _module.args.pkgs = pkgs;
          packages = lib.packagesFromDirectoryRecursive {
            callPackage = lib.callPackageWith pkgs;
            directory = ./pkgs;
          };
          checks = import ./checks {
            inherit
              inputs
              pkgs
              system
              lib
              formatter
              ;
          };
          # Nix formatter available through 'nix fmt' https://github.com/NixOS/nixfmt
          inherit formatter;
          # Custom shell for bootstrapping, nix-config dev, and secrets management
          devShells = import ./shell.nix {
            inherit
              checks
              inputs
              system
              pkgs
              lib
              ;
          };
        };
    };

  inputs = {
    #
    # ========= Official NixOS and HM Package Sources =========
    #
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========= Utilities =========
    #
    flake-parts.url = "github:hercules-ci/flake-parts";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv = {
      # NOTE: devenv pins its own nix build; don't override its nixpkgs
      # so the devenv.cachix binary cache can be used
      url = "github:cachix/devenv/v2.1.2";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========= Desktop (niri + noctalia) =========
    #
    stylix = {
      url = "github:danth/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # v4.7.7 is the final Quickshell-based release; v5 is a beta rewrite.
    # Follows nixpkgs-unstable like upstream (noctalia needs a recent quickshell).
    noctalia = {
      url = "github:noctalia-dev/noctalia?ref=v4.7.7";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    #
    # ========= Personal Repositories =========
    #
    # Private secrets repo.  See ./docs/secretsmgmt.md
    # Authenticates via ssh and use shallow clone
    nix-secrets = {
      url = "git+ssh://git@github.com/asebrech/nix-secrets.git?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========= Claude Code =========
    #
    claude-code = {
      url = "github:ryoppippi/nix-claude-code";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
