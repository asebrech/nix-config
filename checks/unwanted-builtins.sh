#! /usr/bin/env bash
set -euo pipefail

# Prefer `lib` over `builtins` in nix files. A small set of builtins has no
# lib equivalent and is allowlisted. Vendored upstream code is excluded.
if rg -g "*.nix" -g '!hosts/nixos/asahi/apple-silicon-support/**' "builtins\." |
	rg -v '(currentTime|getFlake|getEnv|isNull|readDir|readFile|pathExists|fromJSON|toJSON|substring|hashString)'; then
	echo "Use lib instead of builtins for the matches above."
	exit 1
fi
