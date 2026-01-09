{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  #
  # ========== Arrange Tiles According to Preference ==========
  #
  arrangeTiles = pkgs.writeShellApplication {
    name = "arrangeTiles";
    text = ''
      #!/usr/bin/env bash

      function dispatch(){
          hyprctl dispatch -- "$1"
      }

      # Add your custom tile arrangements here
      # Example:
      # dispatch "focuswindow class:someapp"
      # dispatch "movewindoworgroup l"

      echo "Tile arrangement complete"
    '';
  };

  #
  # ========== Monitor Toggling ==========
  #
  primaryMonitor = lib.head (lib.filter (m: m.primary) osConfig.monitors);

  # Toggle all monitors
  toggleMonitors = pkgs.writeShellApplication {
    name = "toggleMonitors";
    text = ''
      #!/bin/bash

      # Function to get all monitor names
      get_all_monitors() {
          hyprctl monitors -j | jq -r '.[].name'
      }

      # Function to check if all monitors are on
      all_monitors_on() {
          for monitor in $(get_all_monitors); do
              state=$(hyprctl monitors -j | jq -r ".[] | select(.name == \"$monitor\") | .dpmsStatus")
              if [ "$state" != "true" ]; then
                  return 1
              fi
          done
          return 0
      }

      # Main logic
      if all_monitors_on; then
          # If all monitors are on, turn them all off
          for monitor in $(get_all_monitors); do
              hyprctl dispatch dpms off "$monitor"
          done
          echo "All monitors are now off."
      else
          # If any monitor is off, turn them all on
          for monitor in $(get_all_monitors); do
              hyprctl dispatch dpms on "$monitor"
          done
          echo "All monitors are now on."
      fi
    '';
  };

  # Toggle non-primary monitors
  toggleMonitorsNonPrimary = pkgs.writeShellApplication {
    name = "toggleMonitorsNonPrimary";
    text = ''
      #!/bin/bash

      # Define your primary monitor (the one you want to keep on)
      PRIMARY_MONITOR="${primaryMonitor.name}"

      # Function to get all monitor names
      get_all_monitors() {
          hyprctl monitors -j | jq -r '.[].name'
      }

      # Function to check if all monitors are on
      all_monitors_on() {
          for monitor in $(get_all_monitors); do
              state=$(hyprctl monitors -j | jq -r ".[] | select(.name == \"$monitor\") | .dpmsStatus")
              if [ "$state" != "true" ]; then
                  return 1
              fi
          done
          return 0
      }

      # Main logic
      if all_monitors_on; then
          # If all monitors are on, put all except primary into standby
          for monitor in $(get_all_monitors); do
              if [ "$monitor" != "$PRIMARY_MONITOR" ]; then
                  hyprctl dispatch dpms standby "$monitor"
              fi
          done
          echo "All monitors except $PRIMARY_MONITOR are now in standby mode."
      else
          # If not all monitors are on, turn them all on
          for monitor in $(get_all_monitors); do
              hyprctl dispatch dpms on "$monitor"
          done
          echo "All monitors are now on."
      fi
    '';
  };
in
{
  home.packages = [
    arrangeTiles
    toggleMonitors
    toggleMonitorsNonPrimary
  ];
}
