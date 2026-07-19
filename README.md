<div align="center">
<h1>
<img width="100" src="docs/nixos-ascendancy.png" /> <br>
</h1>
</div>

# asebrech's Nix-Config

> Where am I?
>
> > You're in a rabbit hole.
>
> How did I get here?
>
> > The door opened; you got in.

This is my personal NixOS configuration for a MacBook Pro running [Asahi Linux](https://asahilinux.org/). It is heavily based on — and structurally synced with — [EmergentMind's nix-config](https://github.com/EmergentMind/nix-config). If you find something useful here, most of the credit belongs upstream; see [Acknowledgements](#acknowledgements).

## Table of Contents

- [Feature Highlights](#feature-highlights)
- [The Hosts](#the-hosts)
- [Structure Quick Reference](#structure-quick-reference)
- [Daily Usage](#daily-usage)
- [Secrets Management](#secrets-management)
- [Guidance and Resources](#guidance-and-resources)
- [Acknowledgements](#acknowledgements)

---

## Feature Highlights

- Flake-based ([flake-parts](https://github.com/hercules-ci/flake-parts)) NixOS + Home Manager 26.05 configuration
- Full Apple Silicon support: Asahi kernel, m1n1/U-Boot boot chain, peripheral firmware, speaker protection (vendored [nixos-apple-silicon](https://github.com/nix-community/nixos-apple-silicon) module)
- LUKS-encrypted root, with the passphrase prompt available on external displays (Apple display stack loaded in the initrd)
- niri scrollable-tiling compositor with the noctalia shell (bar, launcher, notifications, lock screen); greetd auto-logs into the session — the LUKS passphrase is the gate
- Secrets management via sops-nix and a _private_ `nix-secrets` repo included as a flake input (`mkSecrets` protocol)
- Data-driven, multi-user-capable host user generation from `hostSpec.users`
- Quality gates: pre-commit hooks via git-hooks.nix (nixfmt, deadnix, shellcheck, a `lib`-over-`builtins` policy…) plus bats tests for the sops tooling
- `just` automation recipes for rebuilds, updates, secrets, and ISO building
- Remote/local bootstrap scripts and a standalone `nixos-installer` sub-flake

## The Hosts

|  | Host | Hardware | Role |
|---|---|---|---|
| 🍎 | `asahi` | MacBook Pro 16″ (M1 Pro, 2021) — Asahi Linux | Daily driver |
| 💿 | `iso` | aarch64 image | Recovery / install media |

## Structure Quick Reference

The structure follows EmergentMind's architecture. For the design concepts behind it, see his article and video [Anatomy of a NixOS Config](https://unmovedcentre.com/posts/anatomy-of-a-nixos-config/) — the diagram below is his (v7.1) and this config's layout is directly derived from it (minus darwin, impermanence, and the multi-host fleet).

<div align="center">
<a href="https://unmovedcentre.com/posts/anatomy-of-a-nixos-config/"><img width="400" src="docs/diagrams/anatomy_v7.1.png" /></a>
</div>

- `flake.nix` - Entrypoint for host and home configurations. Also exposes a devshell for bootstrapping tasks (`nix develop`, auto-loaded via direnv).
- `hosts` - NixOS configurations, `sudo nixos-rebuild switch --flake .#<host>` or `just rebuild`.
  - `common` - Shared configurations consumed by the machine-specific ones.
    - `core` - Present across all hosts. This is a hard rule! If something isn't core, it is optional.
    - `optional` - Optional configurations (niri, greetd, openssh, docker, ProtonVPN, keyring…).
    - `users` - Data-driven user generation from `hostSpec.users`.
      - `<user>/keys` - Public ssh keys for the user.
  - `nixos` - Machine-specific configurations, auto-discovered by the flake.
    - `asahi` - The MacBook: `host-spec.nix`, hardware config, and the vendored `apple-silicon-support` module with its firmware.
    - `iso` - Custom NixOS ISO for installation and recovery.
- `home` - Home Manager configurations, built during host rebuilds.
  - `common/core` - Present for the user across all machines (shell, git, ssh, core CLI).
  - `common/optional` - Optional per-host additions (browsers, desktops/niri+noctalia, media, zellij, claude-code…).
  - `<user>` - Per-user entrypoints: `<user>/<host>.nix` + `<user>/common/`.
- `lib` - Custom library (`lib.custom`): `relativeToRoot`, `scanPaths`, and the pre-commit hook set.
- `modules` - Custom modules: `hosts/common/host-spec.nix` (the `hostSpec` options) and shared nix settings.
- `overlays` - Custom modifications to upstream packages (an `unstable` passthrough).
- `pkgs` - Custom packages (currently none — the directory stub keeps the wiring alive).
- `checks` - Flake checks: the pre-commit hook run and the bats test suite.
- `scripts` / `nixos-installer` / `tests` - Bootstrap tooling, standalone installer flake, and bats tests.

## Daily Usage

```bash
just rebuild        # update nix-secrets input, build, switch, verify sops
just check          # full flake check (config + installer)
just upgrade        # update all inputs + rebuild
just iso            # build the recovery image
just diff           # git diff without flake.lock noise
```

The devshell (via `direnv allow`) provides `just`, `nh`, sops tooling, and installs the pre-commit hooks automatically.

## Secrets Management

Secrets live in a private `nix-secrets` repository pulled in as a flake input and managed with [sops-nix](https://github.com/Mic92/sops-nix). The flake consumes it through a `mkSecrets` function, mirroring upstream's protocol. The scripts assume `nix-secrets` is cloned as a sibling of `nix-config` (`~/nix-config`, `~/nix-secrets`).

For the concepts, see EmergentMind's article and video [NixOS Secrets Management](https://unmovedcentre.com/posts/secrets-management/).

## Guidance and Resources

- [NixOS.org Manuals](https://nixos.org/learn/) · [Official Nix Documentation](https://nix.dev) · [Noogle](https://noogle.dev/)
- [NixOS Package Search](https://search.nixos.org/packages) · [Options Search](https://search.nixos.org/options?) · [Home Manager Options](https://home-manager-options.extranix.com/)
- [Asahi Linux](https://asahilinux.org/) · [nixos-apple-silicon](https://github.com/nix-community/nixos-apple-silicon)
- [niri](https://github.com/niri-wm/niri) · [noctalia](https://github.com/noctalia-dev/noctalia) · [stylix](https://github.com/danth/stylix)
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/) by Ryan Yin

## Acknowledgements

- [EmergentMind](https://github.com/EmergentMind) - This configuration started from his [nix-config-starter](https://github.com/EmergentMind/nix-config-starter) and its infrastructure is deliberately kept in sync with his [nix-config](https://github.com/EmergentMind/nix-config). The structure, the justfile, the secrets workflow, the anatomy diagram, and the bones of this very README are his work, adapted. His [YouTube channel](https://www.youtube.com/@Emergent_Mind) and [website](https://unmovedcentre.com) are outstanding NixOS resources.
- The [Asahi Linux](https://asahilinux.org/) team - Linux on Apple Silicon is a small miracle, and they made it.
- [YaLTeR](https://github.com/YaLTeR) and the [noctalia](https://github.com/noctalia-dev) team - niri and noctalia, the desktop this config runs.
- [Mic92](https://github.com/Mic92) and [Lassulus](https://github.com/Lassulus) - sops-nix, disko, nixos-anywhere.
- [Misterio77](https://github.com/Misterio77) and [Ryan Yin](https://github.com/ryan4yin/nix-config) - Structure and reference, by way of upstream.

---

[Return to top](#asebrechs-nix-config)
