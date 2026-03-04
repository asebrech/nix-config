{ pkgs, ... }:
let
  # Pre-build the tmux-which-key init.tmux at Nix build time instead of
  # relying on build.py running at tmux startup (which fails silently).
  whichKeyPlugin = pkgs.tmuxPlugins.tmux-which-key;

  whichKeyConfigYaml = pkgs.writeText "tmux-which-key-config.yaml" ''
    command_alias_start_index: 200
    keybindings:
      prefix_table: Space
    title:
      style: align=centre,bold
      prefix: tmux
      prefix_style: fg=colour4,align=centre,bold
    position:
      x: R
      y: P
    custom_variables: []
    macros: []
    items:
      - name: +Panes
        key: p
        menu:
          - name: Split down
            key: "-"
            command: "split-window -v -c #{pane_current_path}"
          - name: Split right
            key: _
            command: "split-window -h -c #{pane_current_path}"
          - separator: true
          - name: Navigate left
            key: h
            command: select-pane -L
          - name: Navigate down
            key: j
            command: select-pane -D
          - name: Navigate up
            key: k
            command: select-pane -U
          - name: Navigate right
            key: l
            command: select-pane -R
          - separator: true
          - name: Resize left
            key: H
            command: resize-pane -L 2
            transient: true
          - name: Resize down
            key: J
            command: resize-pane -D 2
            transient: true
          - name: Resize up
            key: K
            command: resize-pane -U 2
            transient: true
          - name: Resize right
            key: L
            command: resize-pane -R 2
            transient: true
          - separator: true
          - name: Zoom toggle
            key: z
            command: resize-pane -Z
          - name: Swap next
            key: ">"
            command: swap-pane -D
          - name: Swap prev
            key: "<"
            command: swap-pane -U
          - name: Kill pane
            key: x
            command: kill-pane
      - name: +Windows
        key: w
        menu:
          - name: New window
            key: c
            command: "new-window -c #{pane_current_path}"
          - name: Last window
            key: tab
            command: last-window
          - name: Prev window
            key: h
            command: previous-window
          - name: Next window
            key: l
            command: next-window
          - separator: true
          - name: Rename window
            key: r
            command: "command-prompt -I \"#W\" \"rename-window \\\"%%\\\"\""
          - name: Kill window
            key: x
            command: kill-window
      - name: +Sessions
        key: s
        menu:
          - name: New session
            key: n
            command: new-session
          - name: Find session
            key: f
            command: "command-prompt -p find-session \"switch-client -t %%\""
          - name: Last session
            key: tab
            command: switch-client -l
          - name: Rename session
            key: r
            command: "command-prompt -I \"#S\" \"rename-session \\\"%%\\\"\""
          - separator: true
          - name: Detach
            key: d
            command: detach-client
      - name: +Copy
        key: y
        menu:
          - name: Enter copy mode
            key: c
            command: copy-mode
          - name: Paste buffer
            key: p
            command: paste-buffer -p
          - name: Choose buffer
            key: b
            command: choose-buffer
          - name: List buffers
            key: l
            command: list-buffers
      - separator: true
      - name: Reload config
        key: r
        command: source-file ~/.config/tmux/tmux.conf
      - name: Toggle mouse
        key: m
        command: set -g mouse
  '';

  # Run build.py at Nix build time to produce init.tmux — avoids the fragile
  # runtime Python invocation inside plugin.sh.tmux.
  whichKeyInit = pkgs.runCommand "tmux-which-key-init.tmux" { } ''
    ${whichKeyPlugin}/share/tmux-plugins/tmux-which-key/plugin/build.py \
      ${whichKeyConfigYaml} $out
  '';
in
{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;

    # -- core settings (from gpakosz/.tmux) ------------------------------------
    sensibleOnTop = true; # tmux-sensible runs first, handles $TERM etc.
    terminal = "tmux-256color";
    baseIndex = 1; # windows and panes start at 1
    mouse = true;
    clock24 = true;
    keyMode = "vi";
    escapeTime = 10; # faster command sequences
    historyLimit = 5000;
    focusEvents = true;
    secureSocket = true; # socket in /run/user — survives session

    # -- plugins ---------------------------------------------------------------
    plugins = with pkgs.tmuxPlugins; [
      # yank: clipboard support — auto-detects wl-copy on Wayland
      yank

      # vim-tmux-navigator: seamless C-Arrow navigation across nvim + tmux
      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          # Use Ctrl+Arrow keys (not hjkl) to navigate panes and vim splits
          # The plugin handles the vim-awareness automatically
          set -g @vim_navigator_mapping_left  "C-Left"
          set -g @vim_navigator_mapping_right "C-Right"
          set -g @vim_navigator_mapping_up    "C-Up"
          set -g @vim_navigator_mapping_down  "C-Down"
          set -g @vim_navigator_mapping_prev  "" # disable C-\ binding
        '';
      }

      # resurrect: save and restore sessions across reboots
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }

      # continuum: auto-save every 15 min, auto-restore on tmux start
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }

      # tmux-which-key: popup menu showing all keybindings (prefix + Space)
      # init.tmux is pre-built at Nix build time (see whichKeyInit above);
      # autobuild is disabled so plugin.sh.tmux skips build.py at runtime.
      {
        plugin = tmux-which-key;
        extraConfig = ''
          set -g @tmux-which-key-xdg-enable 1
          set -g @tmux-which-key-disable-autobuild 1
        '';
      }

      # catppuccin: theme — loaded last so it overrides status-bar settings
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"

          # Status bar content
          set -g status-left-length  100
          set -g status-right-length 100
          set -g status-left  "#{E:@catppuccin_status_session}"
          set -g status-right "#{E:@catppuccin_status_user}#{E:@catppuccin_status_host}"
          set -ag status-right "#{E:@catppuccin_status_date_time}"
        '';
      }
    ];

    # -- extra config (gpakosz bindings, adapted) ------------------------------
    extraConfig = ''
      # ===========================================================================
      # Display
      # ===========================================================================

      setw -g automatic-rename on   # rename window to reflect current program
      set  -g renumber-windows on   # renumber windows when one is closed
      set  -g set-titles on         # set terminal title
      set  -g display-panes-time 800
      set  -g display-time 1000
      set  -g status-interval 10

      # ===========================================================================
      # Prefix & reload
      # ===========================================================================

      # C-a as secondary prefix (keeps C-b as default)
      set  -g prefix2 C-a
      bind C-a send-prefix -2

      # r: reload configuration
      bind r source-file "$XDG_CONFIG_HOME/tmux/tmux.conf" \; display "tmux.conf reloaded"

      # ===========================================================================
      # Navigation
      # ===========================================================================

      # Create new session
      bind C-c new-session

      # Find session
      bind C-f command-prompt -p find-session 'switch-client -t %%'

      # Session navigation
      bind BTab switch-client -l  # last session

      # Window splits — retain current path
      unbind '"'
      unbind %
      bind - split-window -v -c '#{pane_current_path}'
      bind _ split-window -h -c '#{pane_current_path}'

      # New window retains current path
      bind c new-window -c '#{pane_current_path}'

      # Pane navigation — plain arrow keys (within tmux only)
      bind -r Left  select-pane -L
      bind -r Right select-pane -R
      bind -r Up    select-pane -U
      bind -r Down  select-pane -D

      # Swap panes
      bind > swap-pane -D
      bind < swap-pane -U

      # Pane resizing — Shift+Arrow
      bind -r S-Left  resize-pane -L 2
      bind -r S-Right resize-pane -R 2
      bind -r S-Up    resize-pane -U 2
      bind -r S-Down  resize-pane -D 2

      # Window navigation
      unbind n
      unbind p
      bind -r C-h previous-window  # prev window
      bind -r C-l next-window       # next window
      bind Tab last-window          # last active window

      # Maximize current pane (built-in zoom)
      bind + resize-pane -Z

      # Toggle mouse
      bind m set -g mouse \; display "mouse #{?mouse,on,off}"

      # Clear screen and tmux history
      bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history

      # ===========================================================================
      # Copy mode (vi)
      # ===========================================================================

      bind Enter copy-mode

      bind -T copy-mode-vi v     send -X begin-selection
      bind -T copy-mode-vi C-v   send -X rectangle-toggle
      bind -T copy-mode-vi y     send -X copy-selection-and-cancel
      bind -T copy-mode-vi H     send -X start-of-line
      bind -T copy-mode-vi L     send -X end-of-line
      bind -T copy-mode-vi Escape send -X cancel

      # ===========================================================================
      # Paste buffers
      # ===========================================================================

      bind b list-buffers
      bind p paste-buffer -p
      bind P choose-buffer

      # ===========================================================================
      # Activity
      # ===========================================================================

      set -g monitor-activity on
      set -g visual-activity off

      # ===========================================================================
      # Pane borders — thin style with active border highlighted
      # ===========================================================================

      set -g pane-border-lines single
    '';
  };

  # tmux-which-key config (source of truth for whichKeyConfigYaml above)
  xdg.configFile."tmux/plugins/tmux-which-key/config.yaml".source = whichKeyConfigYaml;

  # Pre-built init.tmux — generated from config.yaml at Nix build time.
  # plugin.sh.tmux will find this file and skip running build.py at runtime.
  xdg.dataFile."tmux/plugins/tmux-which-key/init.tmux".source = whichKeyInit;

  # tmux shell aliases
  programs.zsh.shellAliases = {
    tl = "tmux";
    tls = "tmux list-sessions";
    tla = "tmux attach";
  };
}
