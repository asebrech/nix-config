# CLAUDE.md — Coding Agent Guide for nix-config

This repository is a **NixOS + Home Manager flake-based system configuration** (nixpkgs/HM **26.05**, flake-parts) for a single Apple Silicon host (`asahi`, a MacBook Pro M1 Pro running Asahi Linux) with the **niri** compositor, the **noctalia** shell, the greetd auto-login entry (LUKS as the real gate) and stylix theming. Its infrastructure is deliberately kept in sync with [EmergentMind's nix-config](https://github.com/EmergentMind/nix-config); private upstream dependencies (introdus) are replaced by local equivalents in `lib/` and `checks/`. A companion private `nix-secrets` repo (sibling checkout at `../nix-secrets`) holds encrypted secrets and exposes a `mkSecrets` function consumed by the flake.

---

## Configuration approach

- **Stock configs + necessary deltas only.** The niri config is the upstream default `config.kdl` with a handful of `// ADAPTED` lines (ghostty terminal, noctalia launcher/shell startup) plus a per-host startup fragment; noctalia declares only the necessary settings (terminal, location, idle timeouts) and defaults everything else. Outputs/scale are auto-detected by niri — don't pin them unless asked.
- The noctalia settings file is declarative, so its in-app Settings panel is read-only: preview changes there, persist them in `home/common/optional/desktops/noctalia.nix`.
- Theming is stylix (catppuccin-mocha) via `modules/hosts/common/auto-styling.nix`, gated on `hostSpec.isAutoStyled`; noctalia colors come from stylix's built-in target.
- Most tools run with stock configuration (helix, zellij, ghostty). Add configuration when it serves a real need, not preemptively.

## Build / Lint / Test Commands

### Primary task runner: `just`

```bash
just                        # List all available recipes
just rebuild                # Update nix-secrets input, build, switch (nh os switch), verify sops
just rebuild-trace          # Rebuild with --show-trace, then flake check
just rebuild-full           # Rebuild + flake check
just upgrade                # Update all inputs + rebuild
just check                  # Full flake check (config + nixos-installer)
just check-sops             # Verify sops-nix activated (journal)
just diff                   # Git diff excluding flake.lock
just iso                    # Build the aarch64 recovery ISO
just fmt                    # nix fmt (nixfmt-rfc-style)
```

### Verification workflow used in this repo

The flake uses the `pipe-operators` experimental feature. The devshell (direnv) and `scripts/rebuild.sh` provide it; for bare nix commands outside the devshell, export:

```bash
export NIX_CONFIG="extra-experimental-features = nix-command flakes pipe-operators"
```

Standard verification ladder after a change (cheapest first):

```bash
# 1. Evaluate the full system (catches most errors, ~30s)
nix eval --raw .#nixosConfigurations.asahi.config.system.build.toplevel.drvPath

# 2. Build without activating
nix build --no-link .#nixosConfigurations.asahi.config.system.build.toplevel

# 3. After boot-critical changes, verify the Asahi boot chain in the closure:
#    m1n1, uboot-apple, linux-asahi, asahi-peripheral-firmware, asahi-audio, speakersafetyd
nix path-info -r <system-path> | grep -iE "m1n1-|uboot-apple|linux-asahi|peripheral|speakersafety"
```

Note: new files must be `git add`ed before the flake sees them.

### Running tests

Tests use [BATS](https://github.com/bats-core/bats-core) and live in `tests/` (they cover the sops helpers in `scripts/helpers.sh`).

```bash
nix flake check --impure            # runs pre-commit hooks + bats in the sandbox
bats tests/sops.bats                # direct run (inside nix develop)
```

---

## Architecture Map

```
flake.nix          flake-parts; mkHost/readHosts auto-discover hosts/nixos/*;
                   customLib = lib extended with ./lib as lib.custom;
                   secrets = inputs.nix-secrets.mkSecrets nixpkgs customLib
lib/               lib.custom.{relativeToRoot, scanPaths, checks.mkPreCommitHooks}
checks/            pre-commit-check (git-hooks.nix) + bats-test
hosts/common/core/ imports for every host: nixos.nix, sops.nix, ssh.nix,
                   modules/hosts/common, hosts/common/users/
hosts/common/users/  data-driven: generates users.users + home-manager wiring
                     from hostSpec.users; per-user dirs users/<name>/{keys/,nixos.nix}
hosts/nixos/asahi/ default.nix (imports + host toggles), host-spec.nix,
                   hardware-configuration.nix, apple-silicon-support/ (VENDORED),
                   firmware/ (Apple firmware blob — data, not a module)
home/<user>/<host>.nix  per-user-per-host entrypoint (home/neo/asahi.nix)
home/common/core/  scanPaths-loaded: git, zsh, ssh, ghostty, starship, direnv…
home/common/optional/  browsers, desktops/ (niri + noctalia), media, zellij,
                       claude-code, sops
modules/hosts/common/  host-spec.nix (the hostSpec option set), nix.nix
```

### `hostSpec` (modules/hosts/common/host-spec.nix)

Central host metadata: `primaryUsername`, `users` (list), `hostName`, `email`, `handle`, `home`, `timeZone`, `isMinimal`, plus `domain`/`userFullName`/`networking` inherited from secrets. `username` is a deprecated alias of `primaryUsername`. Options are only added when something actually reads them.

### Asahi specifics (handle with care)

- `hosts/nixos/asahi/apple-silicon-support/` is **vendored verbatim** from [nixos-apple-silicon](https://github.com/nix-community/nixos-apple-silicon). Never hand-edit it; update it by syncing from upstream. It is excluded from deadnix and the builtins policy.
- The boot chain is m1n1 → U-Boot → systemd-boot. `boot.loader.efi.canTouchEfiVariables = false` and `systemd-boot.graceful = true` are **required** (EFI vars are read-only on Apple Silicon). The ESP is only ~476MB — `configurationLimit = 5` keeps it from filling.
- The initrd loads `appledrm`, `mux_apple_display_crossbar`, `phy_apple_atc` so the LUKS prompt reaches external displays. Transient `dcp … -517` probe-defer messages at boot are harmless.
- The kernel is the Asahi one from the vendored module — never pin `boot.kernelPackages`.
- Firmware in `hosts/nixos/asahi/firmware/` is Apple's (non-redistributable); the repo is meant to be private.

---

## Linting & Formatting

All linting is enforced via `checks/` using `git-hooks.nix`; the hook set is defined in `lib/default.nix` (`lib.custom.checks.mkPreCommitHooks`). Hooks run automatically on commit and via `nix flake check --impure`.

| Tool | Targets | Notes |
|---|---|---|
| `nixfmt-rfc-style` | `*.nix` | Canonical formatter — non-negotiable |
| `deadnix` | `*.nix` | `noLambdaArg = true`; vendored asahi dir excluded |
| `unwanted-builtins` | `*.nix` | **Use `lib.*`, not `builtins.*`** (allowlist: currentTime, getFlake, getEnv, isNull, readDir, readFile, pathExists, fromJSON, toJSON, substring, hashString) |
| `shellcheck` / `shfmt` | shell scripts | `.envrc` excluded from shellcheck |
| `check-added-large-files` | all | Excludes images and the asahi firmware blob |
| misc hygiene | all | merge conflicts, private keys, EOF/whitespace/line endings |

**Always run `nix fmt` before committing any `.nix` file.** `.pre-commit-config.yaml` is auto-generated — never edit it.

---

## Code Style Guidelines

- **Indentation**: 2 spaces (nixfmt enforces everything else).
- **Module args**: destructured set; 3+ args one per line; `...` always present.
- **Package lists**: `lib.attrValues { inherit (pkgs) foo bar; }` with a trailing comment per package.
- **Imports**: `lib.custom.relativeToRoot "path/from/repo/root"` for cross-directory paths; `lib.custom.scanPaths ./.` to auto-import a directory; plain `./file.nix` for siblings.
- **Pipe operators** (`|>`) are used where upstream uses them (overlays, nix.nix).
- **Naming**: options `camelCase`, files/dirs `kebab-case`, bash `snake_case`.
- **Section banners**: `# ========== Section Name ==========` between logical blocks.
- **Comments** state constraints the code can't (why a workaround exists, with the upstream issue link when relevant) — not narration.
- **Conditionals**: `lib.mkIf` / `lib.mkDefault` / `lib.mkForce` / `lib.optionalAttrs`; assertions via `config.assertions` for invariants.
- **Bash**: `set -euo pipefail`; colored output helpers from `scripts/helpers.sh` (`green`/`red`/`yellow`); must pass shellcheck + shfmt.

---

## Git Workflow

**Never create a commit without explicit user instruction.** This is an absolute rule — do not commit even if the work is complete and verified. Stage, report what is ready, and wait for the user to say "commit" (or equivalent). The same applies to pushing.

### Freely allowed

`git status` / `git diff` / `git log` / `git add` / `just diff` (preferred — hides flake.lock noise).

### Requires explicit user authorization

| Action | Rule |
|---|---|
| `git commit` | Only when the user explicitly asks |
| `git push` | Only when the user explicitly asks; the repo should be private before the history is pushed (Apple firmware) |
| `git rebase` / `git reset` / branches / `--amend` / `--force` | Only on direct instruction; never force on `master` |

### Commit message style

Imperative lowercase summary ≤72 chars, no trailing period, optional body explaining why:

```
add docker support for asahi host

Enables the docker service and adds the primary user to the docker
group so containers can be managed without sudo.
```

### Other rules

- **`flake.lock`** is auto-generated; commit its changes only alongside the change that caused them or when an update was requested.
- **Never commit secrets** — verify manually that no sops/age keys are staged; `detect-private-keys` is a backstop, not a guarantee.
- If a pre-commit hook auto-fixes files, stage the fixes and commit again — never `--no-verify`.

---

## Repository Conventions

- **`lib.custom`**: `relativeToRoot`, `scanPaths`, `checks.mkPreCommitHooks` — all in `lib/default.nix`.
- **Secrets**: sops-nix; host key at `/etc/ssh/ssh_host_ed25519_key` decrypts; per-user age keys are bootstrapped automatically. Run `just check-sops` after rebuilds. The `nix-secrets` repo must be pushed for the flake to see changes (or use `--override-input nix-secrets path:/home/neo/nix-secrets` while testing).
- **Desktop stack**: `hosts/common/optional/niri.nix` (compositor + session + desktop services), `services/greetd.nix` (auto-login), `home/common/optional/desktops/` (niri config.kdl assembly + noctalia). Asahi-specific workarounds (idle suspend policy, logind lid rules, initrd display modules) live only in the asahi host/home files, never in shared modules.
- **`nixos-installer/`** is a standalone sub-flake (own lock); `just check` covers it.
- **Cleanup discipline**: when removing a tool, also remove its flake input, its imports, stale comments, *and* its runtime leftovers in `$HOME` (`~/.config`, `~/.cache`, `~/.local/share`) — deep cleanups are expected.
- After structural changes, sweep for stale path references (`hosts/asahi`, `users/primary`, old module names…) across `*.nix`, `*.md`, `justfile`, and `scripts/`.
