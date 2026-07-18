{
  config,
  ...
}:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # Manually configure defaults in settings

    # Global defaults for all hosts
    settings."*" = {
      ControlMaster = "auto";
      ControlPath = "${config.home.homeDirectory}/.ssh/sockets/S.%r@%h:%p";
      ControlPersist = "20m";
      # Avoids infinite hang if control socket connection interrupted. ex: vpn goes down/up
      ServerAliveCountMax = 3;
      ServerAliveInterval = 5; # 3 * 5s
      HashKnownHosts = true;
      AddKeysToAgent = "yes";
    };
  };
  home.file = {
    ".ssh/config.d/.keep".text = "# Managed by Home Manager";
    ".ssh/sockets/.keep".text = "# Managed by Home Manager";
  };
}
