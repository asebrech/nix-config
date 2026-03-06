{
  description = "EmergentMind's Nix-Config Starter";
  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;

      #
      # ========= Architectures =========
      #
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        #"x86_64-linux"
      ];

      #
      # ========= Host Config Functions =========
      #
      # Create a NixOS host configuration
      mkHost = host: {
        ${host} = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            # ========== Extend lib with lib.custom ==========
            # This approach allows lib.custom to propagate into hm
            # see: https://github.com/nix-community/home-manager/pull/3454
            lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
          };
          modules = [ ./hosts/${host} ];
        };
      };
      # Invoke mkHost for each NixOS host config
      mkHostConfigs = hosts: lib.foldl (acc: set: acc // set) { } (lib.map mkHost hosts);
      # Return the hosts declared in the hosts directory (excluding 'common')
      readHosts = lib.filter (name: name != "common") (lib.attrNames (builtins.readDir ./hosts));
    in
    {
      #
      # ========= Overlays =========
      #
      # Custom modifications/overrides to upstream packages.
      overlays = import ./overlays { inherit inputs; };

      #
      # ========= Host Configurations =========
      #
      # Building configurations is available through `just rebuild` or `nixos-rebuild --flake .#hostname`
      nixosConfigurations = mkHostConfigs readHosts;

      #
      # ========= Packages =========
      #
      # Add custom packages to be shared or upstreamed.
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith pkgs;
          directory = ./pkgs/common;
        }
      );

      #
      # ========= Formatting =========
      #
      # Nix formatter available through 'nix fmt' https://nix-community.github.io/nixpkgs-fmt
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
      # Pre-commit checks
      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./checks.nix { inherit inputs system pkgs; }
      );

      #
      # ========= DevShell =========
      #
      # Custom shell for bootstrapping on new hosts, modifying nix-config, and secrets management
      devShells = forAllSystems (
        system:
        import ./shell.nix {
          pkgs = nixpkgs.legacyPackages.${system};
          checks = self.checks.${system};
        }
      );
    };

  inputs = {
    #
    # ========= Official NixOS and Home Manager Package Sources =========
    #
    # Update the NixOS and HM version numbers below when new releases are available.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # The next two inputs are for pinning nixpkgs to stable vs unstable regardless of what the above is set to.
    # This is particularly useful when an upcoming stable release is in beta because you can effectively
    # keep 'nixpkgs-stable' set to stable for critical packages while setting 'nixpkgs' to the beta branch to
    # get a jump start on deprecation changes.
    # See also 'stable-packages' and 'unstable-packages' overlays at 'overlays/default.nix"
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========= Utilities =========
    #
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Secrets management. See ./docs/secretsmgmt.md
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Pre-commit
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========= Theming =========
    #
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      # Don't fetch gnome-shell - we don't use GNOME and gitlab.gnome.org can be unreliable
      inputs.gnome-shell.follows = "";
    };

    #
    # ========= Launcher =========
    #
    vicinae = {
      url = "github:vicinaehq/vicinae";
      # Don't follow nixpkgs to use Cachix cache
    };
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========= Personal Repositories =========
    #
    # Private secrets repo.  See ./docs/secretsmgmt.md
    # Authenticates via ssh and use shallow clone
    nix-secrets = {
      url = "git+ssh://git@github.com/asebrech/nix-secrets.git?ref=main&shallow=1";
      inputs = { };
    };

    #
    # ========= Display Management =========
    #
    hyprdynamicmonitors = {
      url = "github:fiffeek/hyprdynamicmonitors";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
