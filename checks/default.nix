{
  inputs,
  system,
  pkgs,
  lib,
  formatter,
  ...
}:
let
  customLib = import ../lib { inherit lib; };
in
{
  bats-test =
    pkgs.runCommand "bats-test"
      {
        src = ../.;
        buildInputs = lib.attrValues {
          inherit (pkgs)
            bats
            yq-go
            inetutils
            sops
            age
            ;
        };
      }
      ''
        cd $src
        bats tests
        touch $out
      '';

  pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
    src = ../.;
    default_stages = [ "pre-commit" ];
    # nixpkgs' pre-commit is labelled 4.5.1 but its code still behaves as
    # < 4.4 and rejects the new "unsupported" language value that git-hooks
    # emits for >= 4.4. Mask the version so git-hooks keeps using "system".
    package = pkgs.pre-commit // {
      version = "4.3.0";
    };
    # NOTE: Hooks are run in alphabetical order
    hooks = lib.recursiveUpdate (customLib.checks.mkPreCommitHooks pkgs formatter) {
      forbid-submodules = {
        enable = true;
        name = "forbid submodules";
        description = "forbids any submodules in the repository";
        language = "fail";
        entry = "submodules are not allowed in this repository:";
        types = [ "directory" ];
      };

      destroyed-symlinks = {
        enable = true;
        name = "destroyed-symlinks";
        description = "detects symlinks which are changed to regular files with a content of a path which that symlink was pointing to.";
        package = inputs.pre-commit-hooks.checks.${system}.pre-commit-hooks;
        entry = "${inputs.pre-commit-hooks.checks.${system}.pre-commit-hooks}/bin/destroyed-symlinks";
        types = [ "symlink" ];
      };
    };
  };
}
