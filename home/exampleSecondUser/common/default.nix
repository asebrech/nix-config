# FIXME(starter): this is an example of how a secondary user called "exampleSecondUser" can be declared at the home-manager level.
# NOTE that the files here roll up to parent directory that matches the username!
# Modify the directory name and all instances of `exampleSecondUser` in that directories child files to a real username to
# make practical use of them.
# If you have no need for secondary users, simply delete the user's directory from nix-config/home, and ensure that
# your `nix-config/hosts/[platform]/[hostname]/default.nix` files do not import the respective host level files.
# See the instructions for `nix-config/hosts/nixos/hostname1/default.nix` for additional info.

# User-specific configuration common across all of exampleSecondUser's hosts
# This file is for settings that are specific to exampleSecondUser but shared across all hosts

{ pkgs, ... }:
{
  # Example: User-specific settings
  home.packages = builtins.attrValues {
    inherit (pkgs) nix-tree;
  };
}
