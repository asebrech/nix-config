# Reverse Engineering Tools Configuration
#
# Provides Cutter (GUI) with rizin and Ghidra decompiler integration.
# Cutter includes rizin CLI tools, so you get both GUI and CLI in one package.
#
# Usage:
#   cutter <binary>          # GUI: Visual interface with decompiler tab
#   rizin -A <binary>        # CLI: Terminal-based reverse engineering
#   pdg @ main               # CLI: Decompile function to C
#   ghidra                   # Standalone Ghidra GUI

{ pkgs, ... }:
{
  home.packages = [
    # Cutter GUI with rizin CLI and decompiler plugins
    (pkgs.cutter.withPlugins (
      ps: with ps; [
        rz-ghidra # Ghidra decompiler - provides C/C++ pseudocode
        jsdec # JavaScript decompiler (alternative)
        sigdb # Function signature database
      ]
    ))

    # Standalone Ghidra for advanced reverse engineering
    pkgs.ghidra
  ];

  # Rizin configuration
  home.file.".config/rizin/rizinrc".text = ''
    e scr.color=true
    e scr.utf8=true
    e asm.cmt.right=true
    e asm.calls=true
  '';
}
