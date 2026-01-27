# Simple flake update indicator for waybar
# Shows when flake.lock was last modified
{ pkgs }:
pkgs.writeShellScript "system-update.sh" ''
  FLAKE_PATH="$HOME/nix-config"
  LOCK_FILE="$FLAKE_PATH/flake.lock"

  # Get flake.lock modification time
  if [[ ! -f "$LOCK_FILE" ]]; then
    echo '{"text": "󰒑", "tooltip": "No flake.lock found"}'
    exit 0
  fi

  # Calculate days since last update (macOS/Linux compatible)
  LOCK_TIME=$(stat -f %m "$LOCK_FILE" 2>/dev/null || stat -c %Y "$LOCK_FILE" 2>/dev/null)
  NOW=$(date +%s)
  DAYS_AGO=$(( (NOW - LOCK_TIME) / 86400 ))

  # Only show icon if it's been >7 days
  if [[ $DAYS_AGO -gt 7 ]]; then
    echo "{\"text\": \"󰄠\", \"tooltip\": \"Flake updated $DAYS_AGO days ago\\nClick to update\"}"
  else
    echo "{\"text\": \"\", \"tooltip\": \"\"}"
  fi
''
