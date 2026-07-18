# Shell for bootstrapping flake-enabled nix and other tooling
{
  pkgs,
  checks,
  lib,
  ...
}:
{
  default = pkgs.mkShell {
    # Nix utility settings
    NIX_CONFIG = "extra-experimental-features = nix-command flakes pipe-operators";

    # Bootstrap script settings
    BOOTSTRAP_USER = "neo";
    BOOTSTRAP_SSH_PORT = "22";
    BOOTSTRAP_SSH_KEY = "~/.ssh/id_manu";
    NIX_SECRETS_DIR = "/home/neo/nix-secrets";

    buildInputs = checks.pre-commit-check.enabledPackages;
    nativeBuildInputs = lib.attrValues {
      inherit (pkgs)
        nix
        home-manager
        nh
        git
        just
        pre-commit
        sops
        statix

        yq-go # jq for yaml, used for build scripts
        bats # for bash testing
        age # bootstrap script
        ssh-to-age # bootstrap script
        gum # shell script ricing
        ;
    };
    inherit (checks.pre-commit-check) shellHook;
  };
}
