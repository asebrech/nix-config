# AGENTS.md — Coding Agent Guide for nix-config

This repository is a **NixOS + Home Manager flake-based system configuration** for an Apple Silicon
(Asahi Linux) host. It uses Hyprland, Stylix theming, sops-nix for secrets, disko for disk layout,
and nixvim. A companion private `nix-secrets` repo holds encrypted secrets.

---

## Build / Lint / Test Commands

### Primary task runner: `just`

```bash
just                        # List all available recipes
just rebuild                # Standard rebuild (nh os switch or nixos-rebuild)
just rebuild-trace          # Rebuild with --show-trace
just rebuild-full           # Rebuild + flake check
just update                 # Update all flake inputs
just rebuild-update         # Update inputs + rebuild
just check                  # Run full flake check (config + nixos-installer)
just diff                   # Git diff excluding flake.lock
just iso                    # Build and symlink an ISO image
```

### Nix commands (direct)

```bash
nix fmt                                      # Format all .nix files (nixfmt-rfc-style)
nix flake check --impure                     # Run all checks (pre-commit + bats tests)
nix develop                                  # Enter devShell (auto-activated via direnv)
```

### Running tests

Tests use [BATS](https://github.com/bats-core/bats-core) and live in `tests/`.

```bash
# Run all tests (within the Nix sandbox via flake check)
nix flake check --impure

# Run a single test file directly (requires bats in PATH — use nix develop first)
bats tests/sops.bats

# Run a single named test
bats --filter "sops_update_age_key" tests/sops.bats
```

Test files: `tests/sops.bats` (covers helpers in `scripts/helpers.sh`).
Helper library: `tests/helpers/test_helper.bash`.
Fixtures: `tests/fixtures/nix-secrets/`.

### Scripts

```bash
scripts/rebuild.sh [trace|HOSTNAME]          # Wraps nh os switch / sudo nixos-rebuild
scripts/check-sops.sh                        # Verify sops-nix activated in journal
scripts/bootstrap-nixos.sh -n HOST -d IP -k SSH_KEY   # Remote install via nixos-anywhere
scripts/system-install.sh [HOSTNAME]         # Local nixos-rebuild install
```

---

## Linting & Formatting

All linting is enforced via `checks.nix` using `git-hooks.nix` (pre-commit). Hooks run automatically
on commit and can be run manually via `nix flake check --impure`.

| Tool                    | Targets        | Notes                                     |
|-------------------------|----------------|-------------------------------------------|
| `nixfmt-rfc-style`      | `*.nix`        | Canonical formatter — non-negotiable      |
| `deadnix`               | `*.nix`        | `noLambdaArg = true` (unused λ args OK)   |
| `shellcheck`            | shell scripts  | All scripts must pass                     |
| `shfmt`                 | shell scripts  | `-w -l -s` (write, list, simplify)        |
| `check-added-large-files` | all          | Excludes `.png`, `.jpg`, firmware blobs   |
| `detect-private-keys`   | all            | Always enabled                            |
| `trim-trailing-whitespace` | text files  | Always enabled                            |
| `end-of-file-fixer`     | text files     | Always enabled                            |
| `mixed-line-endings`    | text files     | Always enabled                            |

**Always run `nix fmt` before committing any `.nix` file.**

---

## Code Style Guidelines

### Nix formatting

- **Indentation**: 2 spaces — enforced by `nixfmt-rfc-style`.
- **Function arguments**: Use attribute set destructuring. With 3+ arguments, put each on its own
  line:
  ```nix
  {
    config,
    lib,
    pkgs,
    ...
  }:
  ```
  With 1–2 arguments, inline is fine: `{ lib, ... }:`.
- **`...` is always present** in every module argument set, even when all args are named.
- **Lists**: Each element on its own line when there are multiple items.
- **`let`/`in`**: `let` bindings on separate lines; `in` on its own line before the expression.
- **Section banners**: Separate logical sections with:
  ```nix
  #
  # ========== Section Name ==========
  #
  ```
- **FIXME comments**: Use `#FIXME(label): description` for things needing personalization
  (e.g., `#FIXME(starter)`, `#FIXME(bootstrap)`).

### Naming conventions

| Thing                          | Convention                                 |
|--------------------------------|--------------------------------------------|
| NixOS / HM option names        | `camelCase` (`hostName`, `userFullName`)   |
| Boolean options                | `is*`, `use*`, `with*`, `enable*`, `has*` (`isMinimal`, `useYubikey`) |
| `let` block variables          | `camelCase` (`sopsFolder`, `hostSpec`)     |
| File names                     | `kebab-case` (`host-spec.nix`)             |
| Directory names                | `kebab-case` (`nix-secrets`, `cd-gitroot`) |
| Custom package names           | `kebab-case`                               |
| Bash variables                 | `snake_case` (`target_hostname`, `ssh_port`) |
| Overlay names                  | `camelCase` (`stable-packages`, `asahi-overlay`) |

### Imports

Use the appropriate import pattern for context:

```nix
# Cross-directory paths from repo root — preferred for host/module files
imports = lib.flatten [
  (map lib.custom.relativeToRoot [
    "modules/common"
    "hosts/common/core/nixos.nix"
  ])
];

# Auto-import all .nix files in a directory (module index / default.nix files)
imports = lib.custom.scanPaths ./.;

# Computed optional lists from the repo root
imports = lib.flatten [
  ./hardware-configuration.nix
  (map lib.custom.relativeToRoot (
    [ "hosts/common/core" ]
    ++ (map (f: "hosts/common/optional/${f}") [
      "services/bluetooth.nix"
      "hyprland.nix"
    ])
  ))
];

# Simple relative or flake module imports (leaf files)
imports = [ inputs.sops-nix.homeModules.sops ];
```

### Module structure

Every module follows this layout:

```nix
# Optional one-line description comment
{
  config,  # only if config values are read
  lib,     # only if lib functions are used
  pkgs,    # only if packages are needed
  inputs,  # only if flake inputs are needed
  ...
}:
let
  cfg = config.someModule;  # only when options exist
in
{
  imports = [ ... ];  # always first, if present

  options.someModule = {
    enable = lib.mkEnableOption "description";
    field = lib.mkOption {
      type = lib.types.str;
      default = "value";
      description = "Description of the option.";
    };
  };

  config = lib.mkIf cfg.enable {
    # actual configuration
  };
}
```

When there are no options, omit `config = { ... }` and declare attributes directly at the top level.

### Package lists

Use the idiomatic `builtins.attrValues { inherit (pkgs) ...; }` pattern for package lists:

```nix
home.packages = builtins.attrValues {
  inherit (pkgs) ripgrep fd bat eza;
};
```

### Conditionals and overrides

```nix
lib.mkIf condition { ... }          # Conditional config block
lib.mkDefault value                 # Overridable default
lib.mkForce value                   # Unconditional override
lib.optionalAttrs condition { ... } # Conditional attribute set merge
```

### Custom options — `hostSpec`

All host-level custom options live in `modules/common/host-spec.nix` under `config.hostSpec`.
Use `lib.types.submodule` with `freeformType = with lib.types; attrsOf str` to allow extra string
fields alongside typed options.

### Error handling

**Nix modules** — use `config.assertions` for invariant validation:

```nix
config.assertions = [
  {
    assertion = !config.hostSpec.isWork || config.hostSpec.work != null;
    message = "isWork is true but no work attribute set is provided";
  }
];
```

**Bash scripts** — always start with:

```bash
set -euo pipefail
```

Use the colored output helpers from `scripts/helpers.sh`:

```bash
source "$(dirname "$0")/helpers.sh"
green "Success message"
red "Error: something went wrong"
yellow "Warning"
```

All scripts must pass `shellcheck` and `shfmt -s`.

---

## Git Workflow

**Never create a commit without explicit user instruction.** This is an absolute rule — do not
commit even if the work is complete, tests pass, and the change looks clean. Always stop after
staging/editing and wait for the user to say "commit" (or equivalent).

### What agents may do freely

- `git status`, `git diff`, `git log` — read-only inspection at any time
- `git add` — stage files to show what would be committed; fine to do proactively
- `just diff` — preferred way to review changes (excludes `flake.lock` noise)

### What requires explicit user authorization

| Action | Rule |
|---|---|
| `git commit` | Only when the user explicitly asks ("commit this", "create a commit") |
| `git push` | Only when the user explicitly asks; never push speculatively |
| `git rebase` / `git reset` | Only on direct instruction; confirm target ref before running |
| Creating a branch | Only if the user asks for one |
| `--force` / `--force-with-lease` | Never on `main`; only elsewhere on explicit request |
| `git commit --amend` | Only if the commit has not been pushed and user explicitly requests it |

### Commit message style

Use a concise imperative summary line (≤72 chars), optionally followed by a blank line and body:

```
add hyprland idle inhibitor for fullscreen apps

Prevents hypridle from locking the screen when a window is fullscreen,
using the `fullscreen-while-active` special workspace trick.
```

- Start with a lowercase verb: `add`, `fix`, `update`, `remove`, `refactor`
- Do not end the summary line with a period
- Reference the affected module or file when helpful: `fix hosts/asahi: remove stale overlay`

### Other rules

- **`flake.lock`**: treat as auto-generated. Only commit changes to it when `just update` or
  `just rebuild-update` was explicitly requested by the user.
- **Never commit secrets**: `detect-private-keys` runs on every commit, but don't rely on it —
  verify manually that no sops keys, age keys, or `.env` files are staged.
- **Pre-commit hooks run automatically** on `git commit`. If a hook fails (e.g. `nixfmt` reformats
  a file), stage the auto-fixed files and create a new commit — do not use `--no-verify`.

---

## Repository Conventions

- **`lib.custom`** provides two helpers: `relativeToRoot` (resolve a path from the repo root) and
  `scanPaths` (import all `.nix` files in a directory). Both are defined in `lib/default.nix`.
- **Overlays** live in `overlays/default.nix`. Each overlay is a named `let` binding
  (`final: prev: { ... }`) and all are merged with `//`.
- **`inherit`** is used extensively to reduce repetition:
  `inherit inputs outputs;` and `inherit (pkgs) foo bar;`.
- **`deadnix`** runs on every commit — remove unused `let` bindings and imports. Unused lambda
  arguments are exempt (`noLambdaArg = true`).
- **Secrets** are managed with sops-nix. Never commit unencrypted secrets. Run `just check-sops`
  after a rebuild to verify activation.
- **The `nixos-installer/` sub-flake** is standalone; changes there require its own `nix flake check`.
- **`.pre-commit-config.yaml`** is auto-generated — do not edit it manually.
