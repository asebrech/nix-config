
# Define path to helpers
export HELPERS_PATH := justfile_directory() + "/scripts/helpers.sh"

[private]
default:
    @just --list

# Update commonly changing flakes and prep for a build
[private]
rebuild-pre HOST=`hostname`:
    just update-nix-secrets {{ HOST }} && \
    git add --intent-to-add .

# Run post-build checks, like if sops is running properly afterwards
[private]
rebuild-post: check-sops

# Run a flake check on the config and installer
[group("checks")]
check HOST=`hostname` ARGS="":
    NIXPKGS_ALLOW_UNFREE=1 REPO_PATH=$(pwd) nix flake check \
        --impure \
        --keep-going \
        --show-trace \
        {{ ARGS }}
    cd nixos-installer && \
        NIXPKGS_ALLOW_UNFREE=1 REPO_PATH=$(pwd) nix flake check \
        --impure \
        --keep-going \
        --show-trace \
        {{ ARGS }}

# Check if sops-nix activated successfully
[group("checks")]
check-sops:
    scripts/check-sops.sh

# Rebuild the specified host
[group("building")]
rebuild HOST=`hostname`: && rebuild-post
    @just rebuild-host {{ HOST }}

# Rebuild the system and then run a flake check
[group("building")]
rebuild-full HOST=`hostname`: && rebuild-post
    @just rebuild-host {{ HOST }}
    just check {{ HOST }}

# Rebuild the system with verbose tracing
[group("building")]
rebuild-trace HOST=`hostname`: && rebuild-post
    @just rebuild-pre {{ HOST }}
    scripts/rebuild.sh trace
    just check {{ HOST }}

# Run the rebuild script for the local host
[group("building")]
rebuild-host HOST=`hostname`:
    @just rebuild-pre {{ HOST }}
    scripts/rebuild.sh

# Update all flake inputs for the specified host or the current host if none specified
[group("update")]
update HOST=`hostname` *INPUT:
    nix flake update {{ INPUT }} --timeout 5

# Update and then rebuild
[group("building")]
upgrade: update rebuild

# Update nix-secrets flake
[group("update")]
update-nix-secrets HOST=`hostname`:
    @(cd ../nix-secrets 2>/dev/null && git fetch && git rebase > /dev/null || echo "Push your nix-secrets changes") || true
    @just update {{ HOST }} nix-secrets

# Build an iso image for installing new systems and create a symlink for qemu usage
[group("building")]
iso:
    # If we dont remove this folder, libvirtd VM doesnt run with the new iso
    rm -rf result
    nix build --impure .#nixosConfigurations.iso.config.system.build.isoImage && ln -sf result/iso/*.iso latest.iso

# Install the latest iso to a flash drive
[group("building")]
iso-install DRIVE: iso
    sudo dd if=$(eza --sort changed result/iso/*.iso | tail -n1) of={{ DRIVE }} bs=4M status=progress oflag=sync

# Configure a drive password using disko
[group("misc")]
disko DRIVE PASSWORD:
    echo "{{ PASSWORD }}" > /tmp/disko-password
    sudo nix --experimental-features "nix-command flakes pipe-operators" run github:nix-community/disko -- \
      --mode disko \
      hosts/common/disks/btrfs-disk.nix \
      --arg disk '"{{ DRIVE }}"' \
      --arg password '"{{ PASSWORD }}"'
    rm /tmp/disko-password

# Git diff the entire repo except for flake.lock
[group("dev")]
diff:
    git diff ':!flake.lock'

# Refresh dev environment with updated inputs
[group("dev")]
dev:
    @just rebuild-pre
    direnv reload

# Format all tracked nix files (bare `nix fmt` no longer passes a path,
# and the vendored apple-silicon-support dir must stay untouched)
[group("dev")]
fmt:
    git ls-files '*.nix' | grep -v 'apple-silicon-support/' | xargs nixfmt

#
# ========== Nix-Secrets manipulation recipes ==========
#

# Generate a new age key
[group("secrets")]
age-key:
    nix-shell -p age --run "age-keygen"

# Update sops keys in nix-secrets repo
[group("secrets")]
sops-rekey:
    cd ../nix-secrets && for file in $(ls sops/*.yaml); do \
      sops updatekeys -y $file; \
    done

# Update all keys in sops/*.yaml files in nix-secrets to match the creation rules keys
[group("secrets")]
rekey: sops-rekey
    cd ../nix-secrets && \
      (pre-commit run --all-files || true) && \
      git add -u && (git commit -nm "chore: rekey" || true) && git push

# Update an age key anchor or add a new one
[group("secrets")]
sops-update-age-key FIELD KEYNAME KEY:
    #!/usr/bin/env bash
    source {{ HELPERS_PATH }}
    sops_update_age_key {{ FIELD }} {{ KEYNAME }} {{ KEY }}

# Update an existing user age key anchor or add a new one
[group("secrets")]
sops-update-user-age-key USER HOST KEY:
    just sops-update-age-key users {{ USER }}_{{ HOST }} {{ KEY }}

# Update an existing host age key anchor or add a new one
[group("secrets")]
sops-update-host-age-key HOST KEY:
    just sops-update-age-key hosts {{ HOST }} {{ KEY }}

# Automatically create creation rules entries for a <host>.yaml file for host-specific secrets
[group("secrets")]
sops-add-host-creation-rules USER HOST:
    #!/usr/bin/env bash
    source {{ HELPERS_PATH }}
    sops_add_host_creation_rules "{{ USER }}" "{{ HOST }}"

# Automatically create creation rules entries for a shared.yaml file for shared secrets
[group("secrets")]
sops-add-shared-creation-rules USER HOST:
    #!/usr/bin/env bash
    source {{ HELPERS_PATH }}
    sops_add_shared_creation_rules "{{ USER }}" "{{ HOST }}"

# Automatically add the host and user keys to creation rules for shared.yaml and <host>.yaml
[group("secrets")]
sops-add-creation-rules USER HOST:
    just sops-add-host-creation-rules {{ USER }} {{ HOST }} && \
    just sops-add-shared-creation-rules {{ USER }} {{ HOST }}

#
# ========= Admin Recipes ==========
#

# Copy all the config files to the remote host
[group("admin")]
sync USER HOST PATH:
    rsync -av --filter=':- .gitignore' -e "ssh -l {{ USER }} -oport=22" . {{ USER }}@{{ HOST }}:{{ PATH }}/nix-config
