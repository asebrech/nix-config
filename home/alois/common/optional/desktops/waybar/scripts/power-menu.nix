# Power menu script
# Adapted from mechabar: scripts/power-menu.sh
{ pkgs }:
pkgs.writeShellScript "power-menu.sh" ''
  #!/usr/bin/env bash
  # Launch a power menu

  selected=$(printf "%s\n" "Lock" "Shutdown" "Reboot" "Logout" "Hibernate" "Suspend" | \
    ${pkgs.fzf}/bin/fzf \
      --border=sharp \
      --border-label=" Power Menu " \
      --height=~100% \
      --highlight-line \
      --no-input \
      --pointer="" \
      --reverse)

  case $selected in
    "Lock")      ${pkgs.systemd}/bin/loginctl lock-session ;;
    "Shutdown")  ${pkgs.systemd}/bin/systemctl poweroff ;;
    "Reboot")    ${pkgs.systemd}/bin/systemctl reboot ;;
    "Logout")    ${pkgs.systemd}/bin/loginctl terminate-session "$XDG_SESSION_ID" ;;
    "Hibernate") ${pkgs.systemd}/bin/systemctl hibernate ;;
    "Suspend")   ${pkgs.systemd}/bin/systemctl suspend ;;
    *)           exit 1 ;;
  esac
''
